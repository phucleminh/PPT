`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:08:22 03/17/2021 
// Design Name: 
// Module Name:    RGB2Gray 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RGB2Gray(
output valid_out,
output[31:0] Gray_out,
input[7:0] Red_in, Green_in, Blue_in,
input clk, rst_n, valid_in
    );

wire[31:0] Red_prod, Green_prod, Blue_prod, Gray;
wire Red_done, Green_done, Blue_done;
wire[31:0] sum, Blue_delay;
wire sum_done;
wire[31:0] Red, Green, Blue;
wire done_convertR, done_convertG, done_convertB, done_add;

int_to_fp convert_fpR(Red, done_convertR, Red_in, valid_in, clk, rst_n);
int_to_fp convert_fpG(Green, done_convertG, Green_in, valid_in, clk, rst_n);
int_to_fp convert_fpB(Blue, done_convertB, Blue_in, valid_in, clk, rst_n);

FP_Mult Scale_Red   (Red_done,   Red_prod,   Red,   32'h3e991687, clk, rst_n, done_convertR);
FP_Mult Scale_Green (Green_done, Green_prod, Green, 32'h3f1645a2, clk, rst_n, done_convertG);
FP_Mult Scale_Blue  (Blue_done,  Blue_prod,  Blue,  32'h3e1374bc, clk, rst_n, done_convertB);

FP_Add Adder1(sum_done, sum, Red_prod, Green_prod, clk, rst_n, Red_done);
Clock_Delay#(32, 7) Delay(Blue_delay, Blue_prod, clk, rst_n, Green_done);

FP_Add Adder2(valid_out, Gray_out, sum, Blue_delay, clk, rst_n, sum_done);

endmodule
