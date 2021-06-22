module k_1_line_buffer(valid_out,out1,out2,out3,out4,out5,out6,out7,out8,out9,data,clk,resetn,enable,valid_in);
parameter DATA_WIDTH = 32;
parameter WIDTH_IMG = 28;
parameter TEMP = 0;
parameter FIRST_LAYER = 1;
parameter count_num = (WIDTH_IMG*2+2);

output valid_out;
output [DATA_WIDTH-1:0] out1,out2,out3,out4,out5,out6,out7,out8,out9;
input [DATA_WIDTH-1:0] data;
input clk, resetn, enable,valid_in;

wire [DATA_WIDTH-1:0] w9,w8,w7,w6,w5,w4,w3,w2,w1;

assign w9 = data;
//nbit_dff#(32) inst8 (w9,data,clk,resetn,enable);
nbit_dff#(DATA_WIDTH) inst0 (w8,w9,clk,resetn,valid_in);
nbit_dff#(DATA_WIDTH) inst1 (w7,w8,clk,resetn,valid_in);
line_buffer#(WIDTH_IMG, DATA_WIDTH) inst6(w6,w9,clk,resetn,valid_in);
nbit_dff#(DATA_WIDTH) inst2 (w5,w6,clk,resetn,valid_in);
nbit_dff#(DATA_WIDTH) inst3 (w4,w5,clk,resetn,valid_in);
line_buffer#(WIDTH_IMG, DATA_WIDTH) inst7(w3,w6,clk,resetn,valid_in);
nbit_dff#(DATA_WIDTH) inst4 (w2,w3,clk,resetn,valid_in);
nbit_dff#(DATA_WIDTH) inst5 (w1,w2,clk,resetn,valid_in);

//counter_buffer count(valid_out, count_num, clk, resetn, enable);

//Clock_Delay#(1, count_num+LAYER_NO*4+FIRST_LAYER) delay(valid_out, valid_in, clk, resetn, enable);

reg[9:0] count;
reg[9:0] count2;

always@(posedge clk or negedge resetn) begin
    if(!resetn) begin
        count <= 'd0;
    end
    else begin
        if(valid_in) begin
            if(count < (count_num-2+FIRST_LAYER)+(WIDTH_IMG*(WIDTH_IMG-2)-1))
                count <= count + 1'b1;
            else count <= FIRST_LAYER;
        end
        else count <= count;
    end
end

wire valid_internal;
assign valid_internal = (count>=count_num-2+FIRST_LAYER)?valid_in:1'b0;

Clock_Delay#(1, 2+TEMP) delay(valid_out, valid_internal, clk, resetn, enable);

//always@(posedge clk or negedge resetn) begin
//    if(!resetn) begin
//        count2 <= 'd0;
//    end
//    else begin
//        if(valid_in) begin
//            if(count2 < WIDTH_IMG*WIDTH_IMG)
//                count2 <= count2 + 1'b1;
//            else count2 <= count2;
//        end
//        else count2 <= count2;
//    end
//end

//assign valid_out = (count2<((WIDTH_IMG)*(WIDTH_IMG-2)))?valid_internal:1'b0;

assign out1 = w1;
assign out2 = w2;
assign out3 = w3;
assign out4 = w4;
assign out5 = w5;
assign out6 = w6;
assign out7 = w7;
assign out8 = w8;
assign out9 = w9;

endmodule
