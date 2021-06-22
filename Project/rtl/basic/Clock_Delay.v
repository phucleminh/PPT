`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:21 01/20/2021 
// Design Name: 
// Module Name:    Clock_Delay 
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
module Clock_Delay#(
parameter WIDTH = 32,
parameter NUM_CLOCK = 3
)(
output[WIDTH-1:0] out,
input[WIDTH-1:0] in,
input clk, rst_n, start
    );
wire[WIDTH-1:0] temp[NUM_CLOCK-1:0];
	 
genvar i;
generate
	for(i=0; i<NUM_CLOCK; i=i+1) begin : delay_gen
		if(i==0) nbit_dff#(WIDTH) ff(temp[i],in,clk,rst_n,start);
		else nbit_dff#(WIDTH) ff(temp[i],temp[i-1],clk,rst_n,start);
	end
endgenerate

assign out = temp[NUM_CLOCK-1];

endmodule
