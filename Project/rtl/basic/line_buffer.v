module line_buffer(out,in,clk,reset_n,en);
parameter IMG_WIDTH=28;
parameter DATA_WIDTH=32;

output[DATA_WIDTH-1:0] out;
input[DATA_WIDTH-1:0] in;
input clk,reset_n,en;

wire[DATA_WIDTH-1:0] temp[0:IMG_WIDTH-1];

genvar i;
generate
for(i=0; i<IMG_WIDTH; i=i+1) begin :gen_ff
	if(i==0) nbit_dff#(DATA_WIDTH) inst(temp[i], in, clk, reset_n,en);
	else nbit_dff#(DATA_WIDTH) inst(temp[i], temp[i-1], clk, reset_n,en);
end
endgenerate

assign out = temp[IMG_WIDTH-1];

endmodule