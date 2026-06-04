`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:32:51 PM
// Design Name: 
// Module Name: alu
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

module alu (
    input [31:0]  operandA,
    input [31:0]  operandB,
    input [1:0]   alu_control,
    output reg [31:0] result
);
    always @(*) begin
        case (alu_control)
            2'b00:   result = operandA + operandB;    
            2'b01:   result = operandA - operandB;    
            2'b10:   result = ~(operandA & operandB);   
            default: result = 32'b0;
        endcase
    end
endmodule

