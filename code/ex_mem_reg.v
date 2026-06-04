`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:34:55 PM
// Design Name: 
// Module Name: ex_mem_reg
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


module ex_mem_reg (
    input clk,
    input reset,
    input [31:0] alu_result_in,
    input [31:0] writedata_in,   
    input [3:0]  rd_in,            
    input RegWrite_in,
    input MemToReg_in,
    input MemRead_in,
    input MemWrite_in,
    output reg [31:0] alu_result_out,
    output reg [31:0] writedata_out,
    output reg [3:0]  rd_out,
    output reg RegWrite_out,
    output reg MemToReg_out,
    output reg MemRead_out,
    output reg MemWrite_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_result_out <= 32'b0;
            writedata_out  <= 32'b0;
            rd_out         <= 4'b0;
            RegWrite_out   <= 0;  MemToReg_out <= 0;
            MemRead_out    <= 0;  MemWrite_out <= 0;
        end else begin
            alu_result_out <= alu_result_in;
            writedata_out  <= writedata_in;
            rd_out         <= rd_in;
            RegWrite_out   <= RegWrite_in;
            MemToReg_out   <= MemToReg_in;
            MemRead_out    <= MemRead_in;
            MemWrite_out   <= MemWrite_in;
        end
    end
endmodule

