`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:16 12/02/2020 
// Design Name: 
// Module Name:    SLB_counter2 
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
module SLB_counter2(
    output out,
    input clk,
    input rst_n,
    input start
    );

reg count_reg;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) count_reg <= 1'b0;
    else if(start) count_reg <= ~count_reg;
         else count_reg <= count_reg;
end

assign out = count_reg&start;

endmodule
