`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:36:54 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit (
    input [3:0] id_ex_rs,          
    input [3:0] id_ex_rt,         
    input [3:0] ex_mem_rd,       
    input ex_mem_regwrite,   
    input [3:0] mem_wb_rd,    
    input mem_wb_regwrite,  
    output reg [1:0] forwardA, 
    output reg [1:0] forwardB   
);
    always @(*) begin
        if (ex_mem_regwrite && (ex_mem_rd != 4'b0) &&
            (ex_mem_rd == id_ex_rs))
            forwardA = 2'b10;
        else if (mem_wb_regwrite && (mem_wb_rd != 4'b0) &&
                 (mem_wb_rd == id_ex_rs))
            forwardA = 2'b01;
        else
            forwardA = 2'b00;
        if (ex_mem_regwrite && (ex_mem_rd != 4'b0) &&
            (ex_mem_rd == id_ex_rt))
            forwardB = 2'b10;
        else if (mem_wb_regwrite && (mem_wb_rd != 4'b0) &&
                 (mem_wb_rd == id_ex_rt))
            forwardB = 2'b01;
        else
            forwardB = 2'b00;
    end
endmodule

