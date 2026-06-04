`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:40:12 PM
// Design Name: 
// Module Name: regbank
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


module regbank (
    input clk,
    input [3:0] rs, 
    input [3:0] rt, 
    output [31:0] readdata1, 
    output [31:0] readdata2, 
    input [3:0] rd, 
    input [31:0] writedata,
    input regwrite  
);
    reg [31:0] regs [0:15];
    assign readdata1 = (regwrite && (rd == rs)) ? writedata : regs[rs];
    assign readdata2 = (regwrite && (rd == rt)) ? writedata : regs[rt];
    always @(posedge clk)
        if (regwrite)
            regs[rd] <= writedata;
endmodule
