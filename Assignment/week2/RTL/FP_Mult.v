module FP_Mult(
output done,
output[31:0] prod,
input[31:0] a, b,
input clk, rst_n, start
    );

wire sign = a[31]^b[31];
reg[7:0] exp;
reg[7:0] exp_s1, exp_s2;
wire[7:0] exp_so;
wire[47:0] mant;
reg[31:0] prod_tmp2;
wire[31:0] prod_tmp1;
wire[7:0] exp_inc = exp_so + 1'b1;

SA_beh u_SA_beh(mant, {1'b1, a[22:0]}, {1'b1, b[22:0]}, clk, rst_n, start);
Clock_Delay#(1, 28) u_delay_done(done, 1'b1, clk, rst_n, start);
Clock_Delay#(1, 27) u_delay_sign(prod_tmp1[31], sign, clk, rst_n, start);
Clock_Delay#(8, 24) u_delay_exp(exp_so, exp_s1, clk, rst_n, start);
assign prod_tmp1[22:0] = mant[47]?mant[46:24]:mant[45:23];
assign prod_tmp1[30:23] = mant[47]?exp_inc:exp_so;

always@(posedge clk or negedge rst_n) begin
if(!rst_n) begin
	exp <= 8'b0;
	exp_s1 <= 8'b0;
	exp_s2 <= 8'b0;
	prod_tmp2 <= 32'b0;
end
else begin
	if(start) begin
	   exp <= a[30:23] + b[30:23];
		exp_s1 <= exp - 8'd127;
		prod_tmp2[31] <= prod_tmp1[31];
		prod_tmp2[30:23] <= prod_tmp1[30:23];
		prod_tmp2[22:0] <= prod_tmp1[22:0];
	end
end
end

assign prod = prod_tmp2;

endmodule
