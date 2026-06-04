`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:37:52 PM
// Design Name: 
// Module Name: id_ex_reg
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


module id_ex_reg (
    input clk,
    input reset,
    input [31:0] pc_plus4_in,
    input [31:0] readdata1_in,
    input [31:0] readdata2_in,
    input [31:0] signext_in,
    input [3:0]  rs_in,
    input [3:0]  rt_in, 
    input [3:0]  rd_in,  
    input RegWrite_in,
    input MemToReg_in,
    input MemRead_in,
    input MemWrite_in,
    input ALUSrc_in,
    input [1:0] ALUOp_in,
    input stall,
    output reg [31:0] pc_plus4_out,
    output reg [31:0] readdata1_out,
    output reg [31:0] readdata2_out,
    output reg [31:0] signext_out,
    output reg [3:0]  rs_out,
    output reg [3:0]  rt_out,
    output reg [3:0]  rd_out,
    output reg RegWrite_out,
    output reg MemToReg_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg ALUSrc_out,
    output reg [1:0] ALUOp_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_plus4_out  <= 32'b0;
            readdata1_out <= 32'b0;
            readdata2_out <= 32'b0;
            signext_out   <= 32'b0;
            rs_out        <= 4'b0;
            rt_out        <= 4'b0;
            rd_out        <= 4'b0;
            RegWrite_out  <= 0;  MemToReg_out <= 0;
            MemRead_out   <= 0;  MemWrite_out <= 0;
            ALUSrc_out    <= 0;  ALUOp_out    <= 2'b0;
        end else begin
            pc_plus4_out  <= pc_plus4_in;
            readdata1_out <= readdata1_in;
            readdata2_out <= readdata2_in;
            signext_out   <= signext_in;
            rs_out        <= rs_in;
            rt_out        <= rt_in;
            rd_out        <= rd_in;
            if (stall) begin
                RegWrite_out <= 0;  MemToReg_out <= 0;
                MemRead_out  <= 0;  MemWrite_out <= 0;
                ALUSrc_out   <= 0;  ALUOp_out    <= 2'b0;
            end else begin
                RegWrite_out <= RegWrite_in;  MemToReg_out <= MemToReg_in;
                MemRead_out  <= MemRead_in;   MemWrite_out <= MemWrite_in;
                ALUSrc_out   <= ALUSrc_in;    ALUOp_out    <= ALUOp_in;
            end
        end
    end
endmodule
