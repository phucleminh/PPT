module max_pooling(
   input clk, rst_n, enable,
	input [31:0] input1,
	input [31:0] input2,
	input [31:0] input3,
	input [31:0] input4,
   output  [31:0] output_pool,
	output done
    );
	
	parameter initialMax = 32'b0;
	reg [31:0] tempOutput = 32'b0;
	wire done_sub1, done_sub2, done_sub3;
	wire[31:0] input1_s1, input2_s1, input3_s1, input4_s1;
	wire[31:0] sub_in3_s2, sub_in2_s2;
	wire[31:0] sub_out1, sub_out2, sub_out3;
	wire[31:0] sub_in2, sub_in3, output1;
	wire sign1, sign2, sign3;
	
	/*FP_Add sub1(done_sub1, sub_out1, input1, {1'b1 ^ input2[31],input2[30:0]}, clk, rst_n, enable);
	Clock_Delay#(32, 7) sync1(input1_s1, input1, clk, rst_n, enable);
	Clock_Delay#(32, 7) sync2(input2_s1, input2, clk, rst_n, enable);*/
	
	Clock_Delay#(32, 1) sync1(input1_s1, input1, clk, rst_n, enable);
	Clock_Delay#(32, 1) sync2(input2_s1, input2, clk, rst_n, enable);
	assign {sign1, sub_out1} = input1_s1 - input2_s1;
	assign sub_in2 = sign1?input2_s1:input1_s1;
	
	/*FP_Add sub2(done_sub2, sub_out2, input3, {1'b1 ^ input4[31],input4[30:0]}, clk, rst_n, enable);
	Clock_Delay#(32, 7) sync3(input3_s1, input3, clk, rst_n, enable);
	Clock_Delay#(32, 7) sync4(input4_s1, input4, clk, rst_n, enable);*/
	
	Clock_Delay#(32, 1) sync3(input3_s1, input3, clk, rst_n, enable);
	Clock_Delay#(32, 1) sync4(input4_s1, input4, clk, rst_n, enable);
	assign {sign2, sub_out2} = input3_s1 - input4_s1;
	assign sub_in3 = sign2?input4_s1:input3_s1;
	
	/*FP_Add sub3(done_sub3, sub_out3, sub_in2, {1'b1 ^ sub_in3[31],sub_in3[30:0]}, clk, rst_n, done_sub1);
	Clock_Delay#(32, 7) sync5(sub_in3_s2, sub_in3, clk, rst_n, done_sub1);
	Clock_Delay#(32, 7) sync6(sub_in2_s2, sub_in2, clk, rst_n, done_sub1);*/
	
	Clock_Delay#(32, 1) sync5(sub_in3_s2, sub_in3, clk, rst_n, enable);
	Clock_Delay#(32, 1) sync6(sub_in2_s2, sub_in2, clk, rst_n, enable);
	assign {sign3, sub_out3} = sub_in2_s2 - sub_in3_s2;
	assign output1 = sign3?sub_in3_s2:sub_in2_s2;
	
	Clock_Delay#(32, 1) sync7(output_pool, output1, clk, rst_n, enable);
	Clock_Delay#(1, 4) sync8(done, 1'b1, clk, rst_n, enable);
endmodule
