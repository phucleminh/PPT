`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:53 12/01/2020 
// Design Name: 
// Module Name:    buffer 
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
module single_line_buffer#(
	parameter DATA_WIDTH = 32,
	parameter WIDTH_IMG = 26
)(
	 //soutput done,
	 output [DATA_WIDTH-1:0] out0,
    output [DATA_WIDTH-1:0] out1,
    output [DATA_WIDTH-1:0] out2,
    output [DATA_WIDTH-1:0] out3,
    input [DATA_WIDTH-1:0] data,
    input clk,
    input rst_n,
	 input en
    );

reg[4:0] num_count;

assign out3 = data;

//nbit_dff#(32) dff2(out3, data, clk, rst_n, en);

nbit_dff#(DATA_WIDTH) dff0(out2, out3, clk, rst_n, en);

line_buffer#(WIDTH_IMG,DATA_WIDTH) LB(out1, out3, clk, rst_n, en);

nbit_dff#(DATA_WIDTH) dff1(out0, out1, clk, rst_n, en);

//SLB_counter0 count_full(done, count, clk, rst_n);

endmodule
