module convolmulti(valid_out, data_out,clk,resetn,start,valid_in,data,w1,w2,w3,w4,w5,w6,w7,w8,w9);
parameter DATA_WIDTH = 32;
parameter WIDTH_IMG = 28;
parameter TEMP = 0;
parameter FIRST_LAYER = 1;

input clk,resetn,start,valid_in;
input [DATA_WIDTH-1:0] w1,w2,w3,w4,w5,w6,w7,w8,w9,data;
output [DATA_WIDTH-1:0] data_out;
output reg valid_out;
//output valid_out;

wire[8:0] mult_done;
wire [31:0] out1, out2, out3, out4, out5, out6, out7, out8, out9;
wire [31:0] out_mul1, out_mul2, out_mul3, out_mul4, out_mul5, out_mul6, out_mul7, out_mul8, out_mul9, out_mul9_sync;
wire [31:0] out_add0, out_add1, out_add2, out_add3, out_add4, out_add5, out_add6, out_add7;
wire done_add0, done_add1, done_add2, done_add3, done_add4, done_add5, done_add6, done_add7;
wire valid_out_LB;
wire start_mult, valid_conv, valid_conv2;

wire [DATA_WIDTH-1:0]out_mul_register40,out_mul_register41,out_mul_register42,out_mul_register43,out_mul_register44,out_mul_register45,out_mul_register46,out_mul_register47,out_mul_register48;

k_1_line_buffer#(DATA_WIDTH,WIDTH_IMG,TEMP,FIRST_LAYER) inst (valid_out_LB,out1,out2,out3,out4,out5,out6,out7,out8,out9,data,clk,resetn,start,valid_in);

FP_Mult FP_MULT0 (mult_done[0], out_mul1, out9, w9, clk, resetn, start);
FP_Mult FP_MULT1 (mult_done[1], out_mul2, out8, w8, clk, resetn, start);
FP_Mult FP_MULT2 (mult_done[2], out_mul3, out7, w7, clk, resetn, start);
FP_Mult FP_MULT3 (mult_done[3], out_mul4, out6, w6, clk, resetn, start);
FP_Mult FP_MULT4 (mult_done[4], out_mul5, out5, w5, clk, resetn, start);
FP_Mult FP_MULT5 (mult_done[5], out_mul6, out4, w4, clk, resetn, start);
FP_Mult FP_MULT6 (mult_done[6], out_mul7, out3, w3, clk, resetn, start);
FP_Mult FP_MULT7 (mult_done[7], out_mul8, out2, w2, clk, resetn, start);
FP_Mult FP_MULT8 (mult_done[8], out_mul9, out1, w1, clk, resetn, start);

wire mult_delay;
Clock_Delay#(1, 6) delay_mult(mult_delay, valid_out_LB, clk, resetn, start);

FP_Add FP_Add0 (done_add0, out_add0, out_mul1, out_mul2, clk, resetn, start);
FP_Add FP_Add1 (done_add1, out_add1, out_mul3, out_mul4, clk, resetn, start);
FP_Add FP_Add2 (done_add2, out_add2, out_mul5, out_mul6, clk, resetn, start);
FP_Add FP_Add3 (done_add3, out_add3, out_mul7, out_mul8, clk, resetn, start);

wire add_s1_delay;
Clock_Delay#(1, 7) delay_add_s1(add_s1_delay, mult_delay, clk, resetn, start);

FP_Add FP_Add4 (done_add4, out_add4, out_add0, out_add1, clk, resetn, start);
FP_Add FP_Add5 (done_add5, out_add5, out_add2, out_add3, clk, resetn, start);

wire add_s2_delay;
Clock_Delay#(1, 7) delay_add_s2(add_s2_delay, add_s1_delay, clk, resetn, start);

FP_Add FP_Add6 (done_add6, out_add6, out_add5, out_add4, clk, resetn, start);

Clock_Delay#(32, 21) delay_1(out_mul9_sync, out_mul9, clk, resetn, start);

wire add_s3_delay;
Clock_Delay#(1, 7) delay_add_s3(add_s3_delay, add_s2_delay, clk, resetn, start);
FP_Add FP_Add7 (done_add7, out_add7, out_add6, out_mul9_sync, clk, resetn, start);

wire add_s4_delay;
Clock_Delay#(1, 7) delay_add_s4(add_s4_delay, add_s3_delay, clk, resetn, start);

Clock_Delay#(32, 1) delay_output(data_out, out_add7, clk, resetn, start);

//assign data_out = out_add7;
//assign valid_out = add_s4_delay;

reg[5:0] counter;
always@(posedge clk or negedge resetn) begin
    if(!resetn) begin
        counter <= 'd0;
        valid_out <= 1'b0;
    end
    else begin
        if(start) begin
            if(add_s4_delay) begin
                if(counter < WIDTH_IMG-2) begin
                    counter <= counter + 1'b1;
                    valid_out <= add_s4_delay;
                end
                else begin
                    if(counter < WIDTH_IMG-1) begin
                        counter <= counter + 1'b1;
                        valid_out <= 1'b0;
                    end
                    else begin
                        counter <= 'd0;
                        valid_out <= 1'b0;
                    end
                end
            end
            else begin
                counter <= counter;
                valid_out <= 1'b0;
            end
        end
        else begin
            counter <= counter;
            valid_out <= valid_out;
        end
    end
end

endmodule