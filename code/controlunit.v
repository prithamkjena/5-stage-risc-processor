`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:33:36 PM
// Design Name: 
// Module Name: controlunit
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


module controlunit (
    input [3:0] opcode,
    output reg RegWrite,
    output reg MemToReg,
    output reg MemRead,
    output reg MemWrite,
    output reg ALUSrc,
    output reg [1:0] ALUOp
);
    always @(*) begin
        RegWrite = 0;  MemToReg = 0;
        MemRead  = 0;  MemWrite  = 0;
        ALUSrc   = 0;  ALUOp     = 2'b00;

        case (opcode)
            4'b0000: begin         
                RegWrite = 1;
                ALUSrc   = 1;     
                ALUOp    = 2'b01;  
            end
            4'b0100: begin       
                RegWrite = 1;
                MemToReg = 1;    
                MemRead  = 1;
                ALUSrc   = 1;     
                ALUOp    = 2'b00;  
            end
            4'b0010: begin        
                RegWrite = 1;
                ALUSrc   = 0;     
                ALUOp    = 2'b10; 
            end
            4'b0001: begin     
                MemWrite = 1;
                ALUSrc   = 1;    
                ALUOp    = 2'b00;  
            end
            default: ;        
        endcase
    end
endmodule
