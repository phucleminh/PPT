`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:26 01/26/2021 
// Design Name: 
// Module Name:    nbit_dff 
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
module nbit_dff#(
parameter WIDTH = 32
)(
output[WIDTH-1:0] q,
input[WIDTH-1:0] d,
input clk,reset_n,en
    );

genvar i;
generate
   for(i=0; i<WIDTH; i=i+1) begin :gen_nbit_dff
	   dff inst_dff(q[i], d[i], clk, reset_n, en);
	end
endgenerate

endmodule
