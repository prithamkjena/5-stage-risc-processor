`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:39:18 PM
// Design Name: 
// Module Name: mem_wb_reg
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


module mem_wb_reg (
    input clk,
    input reset,
    input [31:0] mem_readdata_in, 
    input [31:0] alu_result_in,
    input [3:0]  rd_in,
    input RegWrite_in,
    input MemToReg_in,
    output reg [31:0] mem_readdata_out,
    output reg [31:0] alu_result_out,
    output reg [3:0]  rd_out,
    output reg RegWrite_out,
    output reg MemToReg_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            mem_readdata_out <= 32'b0;
            alu_result_out   <= 32'b0;
            rd_out           <= 4'b0;
            RegWrite_out     <= 0;
            MemToReg_out     <= 0;
        end else begin
            mem_readdata_out <= mem_readdata_in;
            alu_result_out   <= alu_result_in;
            rd_out           <= rd_in;
            RegWrite_out     <= RegWrite_in;
            MemToReg_out     <= MemToReg_in;
        end
    end
endmodule

