`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 07:41:50 PM
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg clk, reset;

    top dut (
        .clk   (clk),
        .reset (reset)
    );
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        repeat(2) @(posedge clk);
        @(negedge clk);
        reset = 0;
        dut.imem.memory[0] = 32'h0120_000F;
        dut.imem.memory[1] = 32'h4410_0000;
        dut.imem.memory[2] = 32'h4510_0008;
        dut.imem.memory[3] = 32'h2685_0000;
        dut.imem.memory[4] = 32'h1075_0000;
        dut.regbank_inst.regs[2] = 32'h0000_0025; 
        dut.regbank_inst.regs[7] = 32'h0000_000C; 
        dut.regbank_inst.regs[8] = 32'h0009_878C; 
        dut.dmem.memory[5] = 32'hAABB_CCDD;
        dut.dmem.memory[7] = 32'h1122_3344;
        #100
        $finish;
    end
    initial begin
        $dumpfile("pipeline_sim.vcd");
        $dumpvars(0, testbench);
    end
endmodule
