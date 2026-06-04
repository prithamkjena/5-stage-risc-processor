`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:37:19 PM
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection (
    input id_ex_memread,
    input [3:0] id_ex_rd,    
    input [3:0] if_id_rs,   
    input [3:0] if_id_rt,  
    output reg stall
);
    always @(*) begin
        stall = id_ex_memread &&
                ((id_ex_rd == if_id_rs) || (id_ex_rd == if_id_rt));
    end
endmodule
