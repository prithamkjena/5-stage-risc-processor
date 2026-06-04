`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:34:19 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory (
    input        clk,
    input        reset,
    input [31:0] address,   
    input [31:0] writedata, 
    input        memread, 
    input        memwrite,
    output [31:0] readdata 
);
    reg [31:0] memory [0:63];
    assign readdata = memread ? memory[address[7:2]] : 32'b0;
    always @(posedge clk) begin
        if (memwrite)
            memory[address[7:2]] <= writedata;
    end
endmodule
