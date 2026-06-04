`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:38:20 PM
// Design Name: 
// Module Name: if_id_reg
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


module if_id_reg (
    input        clk,
    input        reset,
    input        IFIDWrite,   
    input [31:0] pc_plus4_in,
    input [31:0] instr_in,
    output reg [31:0] pc_plus4_out,
    output reg [31:0] instr_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_plus4_out <= 32'b0;
            instr_out    <= 32'b0;
        end else if (IFIDWrite) begin
            pc_plus4_out <= pc_plus4_in;
            instr_out    <= instr_in;
        end
    end
endmodule
