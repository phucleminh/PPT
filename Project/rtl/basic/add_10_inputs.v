`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2021 05:33:12 PM
// Design Name: 
// Module Name: add_10_inputs
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


module add_10_inputs(
    output valid_out,
    output reg[31:0] out,
    input[31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9,
    input clk, rst_n, valid_in
    );
    
    reg[31:0] out_s0[0:4];
    reg[31:0] out_s1[0:2];
    reg[31:0] out_s2[0:1];
    
    FP_Add inst0(,out_s0[0], in0, in1, clk, rst_n, 1'b1);
    FP_Add inst1(,out_s0[1], in2, in3, clk, rst_n, 1'b1);
    FP_Add inst2(,out_s0[2], in4, in5, clk, rst_n, 1'b1);
    FP_Add inst3(,out_s0[3], in6, in7, clk, rst_n, 1'b1);
    FP_Add inst4(,out_s0[4], in8, in9, clk, rst_n, 1'b1);
    
    FP_Add inst5(,out_s1[0], out_s0[0], out_s0[1], clk, rst_n, 1'b1);
    FP_Add inst6(,out_s1[1], out_s0[2], out_s0[3], clk, rst_n, 1'b1);
    Clock_Delay#(32, 7) inst7(out_s1[2], out_s0[4], clk, rst_n, 1'b1);
    
    FP_Add inst8(,out_s2[0], out_s1[0], out_s1[1], clk, rst_n, 1'b1);
    Clock_Delay#(32, 7) inst9(out_s2[1], out_s1[2], clk, rst_n, 1'b1);
    
    FP_Add inst10(,out, out_s2[0], out_s2[1], clk, rst_n, 1'b1);
    
    Clock_Delay#(1, 28) inst11(valid_out, valid_in, clk, rst_n, 1'b1);
    
endmodule
