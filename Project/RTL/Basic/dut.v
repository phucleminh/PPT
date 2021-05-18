module dut(
   output valid_out_gray,
   output[7:0] gray,
   output valid_out_conv,
   output[7:0] out_conv,
   output valid_out_relu,
   output[7:0] out_relu,
   output valid_out_pool,
   output[7:0] out_pool,
   input[7:0] R, G, B,
   input[31:0] w0, w1, w2, w3, w4, w5, w6, w7, w8,
   input clk, rst_n, valid_in
);

wire valid_out_cvt, valid_out1, valid_out3;
wire[31:0] num_cvt, out1, out3;
reg[31:0] out2;
reg valid_out2;

RGB2Gray convert(valid_out_cvt, num_cvt, R, G, B, clk, rst_n, valid_in);
convertfp2int Gray(num_cvt, clk, rst_n, valid_out_cvt, gray, valid_out_gray);

convolmulti#(32, 220, 0, 1) conv(valid_out1, out1, clk, rst_n, 1'b1, valid_out_cvt, num_cvt, w0, w1, w2, w3, w4, w5, w6, w7, w8);
convertfp2int conv2(out1, clk, rst_n, valid_out1, out_conv,);
Clock_Delay#(1,3) delay1(valid_out_conv, valid_out1, clk, rst_n, 1'b1);

always@(posedge clk or negedge rst_n) begin
   if(!rst_n) begin
      out2 <= 'd0; valid_out2 <= 'd0;
   end
   else begin
      out2 <= out1[31]?32'd0:out1;
      valid_out2 <= valid_out1;
   end
end
convertfp2int relu(out2, clk, rst_n, valid_out2, out_relu,);
Clock_Delay#(1,3) delay2(valid_out_relu, valid_out2, clk, rst_n, 1'b1);

pooling_Block#(32, 218) pool(valid_out3, out3, out2, clk, rst_n, valid_out2);
convertfp2int pool2(out3, clk, rst_n, valid_out3, out_pool,);
Clock_Delay#(1,5) delay3(valid_out_pool, valid_out3, clk, rst_n, 1'b1);

endmodule