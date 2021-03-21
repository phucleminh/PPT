module dff(q,d,clk,reset_n,en);
output q;
input d;
input clk,reset_n,en;

reg temp;

always@(posedge clk or negedge reset_n) begin
if(!reset_n) temp<=1'b0;
else if(en) temp<=d;
end
assign q = temp;

endmodule

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
