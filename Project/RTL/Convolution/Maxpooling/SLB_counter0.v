`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:27:48 01/26/2021 
// Design Name: 
// Module Name:    SLB_counter0 
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
module SLB_counter0(
output done,
input[4:0] count,
input clk, rst_n
    );

reg[4:0] num_count;

always@(posedge clk or negedge rst_n) begin
if(!rst_n) num_count <= count;
else num_count <= num_count - 1'b1;
end

assign done = (num_count == 5'b0)?1'b1:1'b0;

endmodule
