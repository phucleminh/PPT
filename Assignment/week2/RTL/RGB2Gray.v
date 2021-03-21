module RGB2Gray(
output done,
output[31:0] Gray,
input[31:0] Red, Green, Blue,
input clk, rst_n, en
    );

wire[31:0] Red_prod, Green_prod, Blue_prod;
wire Red_done, Green_done, Blue_done;
wire[31:0] sum, Blue_delay;
wire sum_done;

FP_Mult Scale_Red   (Red_done,   Red_prod,   Red,   32'h3e59b3d0, clk, rst_n, en);
FP_Mult Scale_Green (Green_done, Green_prod, Green, 32'h3f371759, clk, rst_n, en);
FP_Mult Scale_Blue  (Blue_done,  Blue_prod,  Blue,  32'h3d93dd98, clk, rst_n, en);

FP_Add Adder1(sum_done, sum, Red_prod, Green_prod, clk, rst_n, Red_done);
Clock_Delay#(32, 7) Delay(Blue_delay, Blue_prod, clk, rst_n, Green_done);

FP_Add Adder2(done, Gray, sum, Blue_delay, clk, rst_n, sum_done);

endmodule
