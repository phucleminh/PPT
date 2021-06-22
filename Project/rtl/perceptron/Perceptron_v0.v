`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2021 11:42:49 AM
// Design Name: 
// Module Name: Perceptron
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


module Perceptron_v0(
    output valid_out,
    output[31:0] out,
    input[31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9,
    input[31:0] w,
    input clk, rst_n, valid_in, load_weight
    );
 wire[31:0] mult_out0, mult_out1, mult_out2, mult_out3, mult_out4, mult_out5, mult_out6, mult_out7, mult_out8, mult_out9;
 wire valid_out_mul;
 wire mult_valid_out;
 reg[3:0] addr;
 wire[31:0] out_FIFO[0:9];
 
 serial2parallel_10o FIFO(, out_FIFO[0], out_FIFO[1], out_FIFO[2], out_FIFO[3]
                          , out_FIFO[4], out_FIFO[5], out_FIFO[6], out_FIFO[7]
                          , out_FIFO[8], out_FIFO[9]
                          , w, clk, rst_n, load_weight);
 
 FP_Mult mult0(, mult_out0, in0, out_FIFO[0], clk, rst_n, 1'b1);
 FP_Mult mult1(, mult_out1, in1, out_FIFO[1], clk, rst_n, 1'b1);
 FP_Mult mult2(, mult_out2, in2, out_FIFO[2], clk, rst_n, 1'b1);
 FP_Mult mult3(, mult_out3, in3, out_FIFO[3], clk, rst_n, 1'b1);
 FP_Mult mult4(, mult_out4, in4, out_FIFO[4], clk, rst_n, 1'b1);
 FP_Mult mult5(, mult_out5, in5, out_FIFO[5], clk, rst_n, 1'b1);
 FP_Mult mult6(, mult_out6, in6, out_FIFO[6], clk, rst_n, 1'b1);
 FP_Mult mult7(, mult_out7, in7, out_FIFO[7], clk, rst_n, 1'b1);
 FP_Mult mult8(, mult_out8, in8, out_FIFO[8], clk, rst_n, 1'b1);
 FP_Mult mult9(, mult_out9, in9, out_FIFO[9], clk, rst_n, 1'b1);
 Clock_Delay#(32, 6) delay(valid_out_mul, valid_in, clk, rst_n, 1'b1);

 add_10_inputs add(valid_out, out, out_FIFO[0], out_FIFO[1], out_FIFO[2], out_FIFO[3]
                   , out_FIFO[4], out_FIFO[5], out_FIFO[6], out_FIFO[7]
                   , out_FIFO[8], out_FIFO[9], clk, rst_n, valid_out_mul);

endmodule
