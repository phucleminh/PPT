`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:20 12/01/2020 
// Design Name: 
// Module Name:    pooling_Block 
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
module pooling_Block#(
	parameter DATA_WIDTH = 32,
	parameter WIDTH_IMG = 26
)(
	 output done,
    output [DATA_WIDTH-1:0] out,
    input [DATA_WIDTH-1:0] data,
    input clk,
    input rst_n,
    input en
    );

wire[DATA_WIDTH-1:0] out_SLB0, out_SLB1, out_SLB2, out_SLB3;
wire SLB_count1_done, SLB_count2_done, en_LB, en_counter2;
wire done_pool, valid_pool, valid_pool2, valid_pool3;
assign out1 = out_SLB0;
assign out2 = out_SLB1;
assign out3 = out_SLB2;
assign out4 = out_SLB3;

single_line_buffer#(DATA_WIDTH, WIDTH_IMG) SLB(out_SLB0, out_SLB1, out_SLB2, out_SLB3, data, clk, rst_n, en);
//SLB_counter1#(WIDTH_IMG-1) SLB_count1(SLB_count1_done, clk, rst_n, en);
//Clock_Delay#(1, WIDTH_IMG+5) delay(SLB_count1_done, en, clk, rst_n, 1'b1);

reg[5:0] count;
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) count <= 'd0;
    else
        if(en) 
            if(count!=WIDTH_IMG) count <= count+1'b1;
            else count <= count;
        else count <= count;
end

assign SLB_count1_done = (count==WIDTH_IMG)?en:1'b0;

SLB_counter2 SLB_count2(SLB_count2_done, clk, rst_n, SLB_count1_done);

max_pooling pool(clk, rst_n, 1'b1, out_SLB0, out_SLB1, out_SLB2, out_SLB3, out, done_pool);
pool_counter#(WIDTH_IMG) counter(valid_pool, clk, rst_n, SLB_count1_done);
Clock_Delay#(1, 3) delay_valid2(valid_pool3,SLB_count2_done, clk, rst_n, 1'b1);
Clock_Delay#(1, 3) delay_valid(valid_pool2, valid_pool, clk, rst_n, 1'b1);

assign done = valid_pool3&valid_pool2;

endmodule
