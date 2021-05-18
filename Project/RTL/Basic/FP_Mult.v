`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:44 03/09/2021 
// Design Name: 
// Module Name:    FP_Mult
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
module FP_Mult(
output done,
output[31:0] prod,
input[31:0] a, b,
input clk, rst_n, start
    );

wire sign = a[31]^b[31];
reg[7:0] exp_a, exp_b;
reg[7:0] exp_s1, exp_s2;
wire[7:0] exp_so;
wire[47:0] mant;
reg[31:0] prod_tmp2;
wire[31:0] prod_tmp1;
wire[7:0] exp_inc = exp_so + 1'b1;
wire[31:0] a_sync, b_sync;

ArrayMult2 u_ArrayMult2(mant, {1'b1, a[22:0]}, {1'b1, b[22:0]}, clk, rst_n, start);
Clock_Delay#(32, 5) sync_a(a_sync, a, clk, rst_n, start);
Clock_Delay#(32, 5) sync_b(b_sync, b, clk, rst_n, start);
Clock_Delay#(1, 6) u_delay_done(done, start, clk, rst_n, start);
Clock_Delay#(1, 5) u_delay_sign(prod_tmp1[31], sign, clk, rst_n, start);
Clock_Delay#(8, 2) u_delay_exp(exp_so, exp_s2, clk, rst_n, start);
assign prod_tmp1[22:0] = mant[47]?mant[46:24]:
                         mant[46]?mant[45:23]:
                         mant[45]?mant[44:22]:
                         mant[44]?mant[43:21]:
                         mant[43]?mant[42:20]:
                         mant[42]?mant[41:19]:
                         mant[41]?mant[40:18]:
                         mant[40]?mant[39:17]:
                         mant[39]?mant[38:16]:
                         mant[38]?mant[37:15]:
                         mant[37]?mant[36:14]:
                         mant[36]?mant[35:13]:
                         mant[35]?mant[34:12]:
                         mant[34]?mant[33:11]:
                         mant[33]?mant[32:10]:
                         mant[32]?mant[31:9]:
                         mant[31]?mant[30:8]:
                         mant[30]?mant[29:7]:
                         mant[29]?mant[28:6]:
                         mant[28]?mant[27:5]:
                         mant[27]?mant[26:4]:
                         mant[26]?mant[25:3]:mant[24:2];
                         
assign prod_tmp1[30:23] =    mant[47]?exp_so+1:
                             mant[46]?exp_so:
                             mant[45]?exp_so-1:
                             mant[44]?exp_so-2:
                             mant[43]?exp_so-3:
                             mant[42]?exp_so-4:
                             mant[41]?exp_so-5:
                             mant[40]?exp_so-6:
                             mant[39]?exp_so-7:
                             mant[38]?exp_so-8:
                             mant[37]?exp_so-9:
                             mant[36]?exp_so-10:
                             mant[35]?exp_so-11:
                             mant[34]?exp_so-12:
                             mant[33]?exp_so-13:
                             mant[32]?exp_so-14:
                             mant[31]?exp_so-15:
                             mant[30]?exp_so-16:
                             mant[29]?exp_so-17:
                             mant[28]?exp_so-18:
                             mant[27]?exp_so-19:
                             mant[26]?exp_so-20:exp_so-21;

always@(posedge clk or negedge rst_n) begin
if(!rst_n) begin
	exp_a <= 8'b0;
	exp_b <= 8'b0;
	exp_s1 <= 8'b0;
	exp_s2 <= 8'b0;
	prod_tmp2 <= 32'b0;
end
else begin
	if(start) begin
	    exp_a <= a[30:23] - 8'd127;
		exp_b <= b[30:23] - 8'd127;
		exp_s1 <= exp_a + exp_b;
		exp_s2 <= exp_s1 + 8'd127;
		if(a_sync == 'd0) begin
		      prod_tmp2 <= 'd0;
		end
		else if(b_sync == 'd0) begin
		      prod_tmp2 <= 'd0;
		     end
		     else begin
              prod_tmp2[31] <= prod_tmp1[31];
              prod_tmp2[30:23] <= prod_tmp1[30:23];
              prod_tmp2[22:0] <= prod_tmp1[22:0];
		     end
	end
	else begin
	    exp_a <= exp_a;
		exp_b <= exp_b;
		exp_s1 <= exp_s1;
		exp_s2 <= exp_s2;
		prod_tmp2 <= prod_tmp2;
	end
end
end

assign prod = prod_tmp2;

endmodule
