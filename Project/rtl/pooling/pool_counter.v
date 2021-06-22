`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:39 12/02/2020 
// Design Name: 
// Module Name:    SLB_counter1 
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
module pool_counter#(
	parameter WIDTH_IMG = 26
)(
    output out,
    input clk,
    input rst_n,
    input start
    );

reg[5:0] count_reg;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) count_reg <= 'd0;
    else if(start) if(count_reg != 0) count_reg <= count_reg-1'b1;
                   else count_reg <= WIDTH_IMG*2-1;
         else count_reg <= count_reg;
end

assign out = (count_reg>=WIDTH_IMG)?1'b1:1'b0;

endmodule
