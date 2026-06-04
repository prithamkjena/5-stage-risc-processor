`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:41:01 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (
    input clk,
    input reset
);
    wire stall; 
    wire PCWrite    = ~stall;  
    wire IFIDWrite  = ~stall;        
    wire [31:0] pc_out;
    wire [31:0] pc_plus4 = pc_out + 32'd4;
    PC pc_inst (
        .clk     (clk),
        .reset   (reset),
        .PCWrite (PCWrite),
        .pc_next (pc_plus4),
        .pc_out  (pc_out)
    );
    wire [31:0] if_instr;
    instruction_memory imem (
        .address  (pc_out),
        .readdata (if_instr)
    );
    wire [31:0] if_id_pc_plus4;
    wire [31:0] if_id_instr;

    if_id_reg if_id_reg_inst (
        .clk          (clk),
        .reset        (reset),
        .IFIDWrite    (IFIDWrite),
        .pc_plus4_in  (pc_plus4),
        .instr_in     (if_instr),
        .pc_plus4_out (if_id_pc_plus4),
        .instr_out    (if_id_instr)
    );
    wire [3:0]  id_opcode = if_id_instr[31:28];
    wire [3:0]  id_rd     = if_id_instr[27:24]; 
    wire [3:0]  id_rs     = if_id_instr[23:20]; 
    wire [3:0]  id_rt     = if_id_instr[19:16]; 
    wire [15:0] id_imm    = if_id_instr[15:0];
    wire id_regwrite, id_memtoreg, id_memread, id_memwrite, id_alusrc;
    wire [1:0] id_aluop;

    controlunit ctrl (
        .opcode   (id_opcode),
        .RegWrite (id_regwrite),
        .MemToReg (id_memtoreg),
        .MemRead  (id_memread),
        .MemWrite (id_memwrite),
        .ALUSrc   (id_alusrc),
        .ALUOp    (id_aluop)
    );
    wire [3:0]  wb_rd;
    wire [31:0] wb_writedata;
    wire wb_regwrite;
    wire [31:0] id_readdata1, id_readdata2;

    regbank regbank_inst (
        .clk       (clk),
        .rs        (id_rs),
        .rt        (id_rt),
        .readdata1 (id_readdata1),
        .readdata2 (id_readdata2),
        .rd        (wb_rd),
        .writedata (wb_writedata),
        .regwrite  (wb_regwrite)
    );
    wire [31:0] id_signext;

    signextend sext (
        .imm_in  (id_imm),
        .imm_out (id_signext)
    );
    wire [3:0] id_ex_rd;
    wire       id_ex_memread;

    hazard_detection hazard_det (
        .id_ex_memread (id_ex_memread),
        .id_ex_rd      (id_ex_rd),
        .if_id_rs      (id_rs),
        .if_id_rt      (id_rt),
        .stall         (stall)
    );
    wire [31:0] id_ex_pc_plus4;
    wire [31:0] id_ex_readdata1;
    wire [31:0] id_ex_readdata2;
    wire [31:0] id_ex_signext;
    wire [3:0]  id_ex_rs, id_ex_rt;
    wire id_ex_regwrite, id_ex_memtoreg;
    wire id_ex_memwrite, id_ex_alusrc;
    wire [1:0]  id_ex_aluop;

    id_ex_reg id_ex_reg_inst (
        .clk           (clk),
        .reset         (reset),
        .pc_plus4_in   (if_id_pc_plus4),
        .readdata1_in  (id_readdata1),
        .readdata2_in  (id_readdata2),
        .signext_in    (id_signext),
        .rs_in         (id_rs),
        .rt_in         (id_rt),
        .rd_in         (id_rd),
        .RegWrite_in   (id_regwrite),
        .MemToReg_in   (id_memtoreg),
        .MemRead_in    (id_memread),
        .MemWrite_in   (id_memwrite),
        .ALUSrc_in     (id_alusrc),
        .ALUOp_in      (id_aluop),
        .stall         (stall),
        .pc_plus4_out  (id_ex_pc_plus4),
        .readdata1_out (id_ex_readdata1),
        .readdata2_out (id_ex_readdata2),
        .signext_out   (id_ex_signext),
        .rs_out        (id_ex_rs),
        .rt_out        (id_ex_rt),
        .rd_out        (id_ex_rd),
        .RegWrite_out  (id_ex_regwrite),
        .MemToReg_out  (id_ex_memtoreg),
        .MemRead_out   (id_ex_memread),
        .MemWrite_out  (id_ex_memwrite),
        .ALUSrc_out    (id_ex_alusrc),
        .ALUOp_out     (id_ex_aluop)
    );
    wire [3:0]  ex_mem_rd;
    wire        ex_mem_regwrite;
    wire [3:0]  mem_wb_rd;
    wire        mem_wb_regwrite;
    wire [31:0] ex_mem_alu_result;
    wire        mem_wb_memtoreg;
    wire [31:0] mem_wb_alu_result;
    wire [31:0] mem_wb_mem_readdata;
    assign wb_writedata = mem_wb_memtoreg ? mem_wb_mem_readdata
                                          : mem_wb_alu_result;
    assign wb_rd        = mem_wb_rd;
    assign wb_regwrite  = mem_wb_regwrite;
    wire [1:0] forwardA, forwardB;
    forwarding_unit fwd_unit (
        .id_ex_rs        (id_ex_rs),
        .id_ex_rt        (id_ex_rt),
        .ex_mem_rd       (ex_mem_rd),
        .ex_mem_regwrite (ex_mem_regwrite),
        .mem_wb_rd       (mem_wb_rd),
        .mem_wb_regwrite (mem_wb_regwrite),
        .forwardA        (forwardA),
        .forwardB        (forwardB)
    );
    wire [31:0] alu_operandA =
        (forwardA == 2'b10) ? ex_mem_alu_result :
        (forwardA == 2'b01) ? wb_writedata       :
                              id_ex_readdata1;
    wire [31:0] forwardB_out =
        (forwardB == 2'b10) ? ex_mem_alu_result :
        (forwardB == 2'b01) ? wb_writedata       :
                              id_ex_readdata2;
    wire [31:0] alu_operandB = id_ex_alusrc ? id_ex_signext : forwardB_out;
    wire [31:0] ex_alu_result;
    alu alu_inst (
        .operandA    (alu_operandA),
        .operandB    (alu_operandB),
        .alu_control (id_ex_aluop),
        .result      (ex_alu_result)
    );
    wire [31:0] ex_mem_writedata;
    wire        ex_mem_memtoreg;
    wire        ex_mem_memread;
    wire        ex_mem_memwrite;
    ex_mem_reg ex_mem_reg_inst (
        .clk             (clk),
        .reset           (reset),
        .alu_result_in   (ex_alu_result),
        .writedata_in    (forwardB_out),  
        .rd_in           (id_ex_rd),
        .RegWrite_in     (id_ex_regwrite),
        .MemToReg_in     (id_ex_memtoreg),
        .MemRead_in      (id_ex_memread),
        .MemWrite_in     (id_ex_memwrite),
        .alu_result_out  (ex_mem_alu_result),
        .writedata_out   (ex_mem_writedata),
        .rd_out          (ex_mem_rd),
        .RegWrite_out    (ex_mem_regwrite),
        .MemToReg_out    (ex_mem_memtoreg),
        .MemRead_out     (ex_mem_memread),
        .MemWrite_out    (ex_mem_memwrite)
    );
    wire [31:0] mem_readdata;
    data_memory dmem (
        .clk       (clk),
        .reset     (reset),
        .address   (ex_mem_alu_result),
        .writedata (ex_mem_writedata),
        .memread   (ex_mem_memread),
        .memwrite  (ex_mem_memwrite),
        .readdata  (mem_readdata)
    );
    mem_wb_reg mem_wb_reg_inst (
        .clk              (clk),
        .reset            (reset),
        .mem_readdata_in  (mem_readdata),
        .alu_result_in    (ex_mem_alu_result),
        .rd_in            (ex_mem_rd),
        .RegWrite_in      (ex_mem_regwrite),
        .MemToReg_in      (ex_mem_memtoreg),
        .mem_readdata_out (mem_wb_mem_readdata),
        .alu_result_out   (mem_wb_alu_result),
        .rd_out           (mem_wb_rd),
        .RegWrite_out     (mem_wb_regwrite),
        .MemToReg_out     (mem_wb_memtoreg)
    );
endmodule
