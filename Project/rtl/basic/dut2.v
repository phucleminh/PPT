`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2021 09:14:19 PM
// Design Name: 
// Module Name: dut2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dut2#(
    parameter NO_KERNEL = 10,
    parameter NO_KERNEL1 = 10,
    parameter NO_KERNEL2 = 10,
    parameter NO_KERNEL3 = 10,
    parameter NO_KERNEL4 = 10,
    parameter NO_KERNEL5 = 10
)(
    output valid_out,
    output[31:0] predict0,
    output[31:0] predict1,
    output load_k0_done, load_k1_done, load_k2_done, load_k3_done, load_k4_done, load_k5_done, load_w_done,
    input[7:0] pixel_R, pixel_G, pixel_B,
    input[31:0] ker0, ker1, ker2, ker3, ker4, ker5,
    input[31:0] w0_0, w0_1,
    input clk, rst_n, valid_in, load_k0, load_k1, load_k2, load_k3, load_k4, load_k5, load_w
);

wire[31:0] k0[9*NO_KERNEL-1:0];
wire[31:0] k1[9*NO_KERNEL*NO_KERNEL1-1:0];
wire[31:0] k2[9*NO_KERNEL1*NO_KERNEL2-1:0];
wire[31:0] k3[9*NO_KERNEL2*NO_KERNEL3-1:0];
wire[31:0] k4[9*NO_KERNEL1*NO_KERNEL2-1:0];
wire[31:0] k5[9*NO_KERNEL2*NO_KERNEL3-1:0];

wire val_o[NO_KERNEL-1:0];
wire val_o2[NO_KERNEL-1:0];
wire val_o_add0[NO_KERNEL-1:0];
wire val_o_pool0[NO_KERNEL-1:0];

wire val_o3[NO_KERNEL*NO_KERNEL1-1:0];
wire val_o4[NO_KERNEL-1:0];
wire val_o_add1[NO_KERNEL-1:0];
wire val_o_pool1[NO_KERNEL-1:0];

wire val_o5[NO_KERNEL*NO_KERNEL1-1:0];
wire val_o6[NO_KERNEL-1:0];
wire val_o_add2[NO_KERNEL-1:0];
wire val_o_pool2[NO_KERNEL-1:0];

wire val_o7[NO_KERNEL*NO_KERNEL1-1:0];
wire val_o8[NO_KERNEL-1:0];
wire val_o_add3[NO_KERNEL-1:0];
wire val_o_pool3[NO_KERNEL-1:0];

wire[31:0] out_conv[NO_KERNEL-1:0];
wire[31:0] out_conv2[NO_KERNEL*NO_KERNEL1-1:0];
wire[31:0] out_add0[NO_KERNEL-1:0];
wire[31:0] out_pool0[NO_KERNEL-1:0];

wire[31:0] out_conv3[NO_KERNEL*NO_KERNEL1-1:0];
wire[31:0] out_conv4[NO_KERNEL*NO_KERNEL1-1:0];
wire[31:0] out_add1[NO_KERNEL-1:0];
wire[31:0] out_pool1[NO_KERNEL-1:0];

wire[31:0] out_conv5[NO_KERNEL*NO_KERNEL1-1:0];
wire[31:0] out_conv6[NO_KERNEL*NO_KERNEL1-1:0];
wire[31:0] out_add2[NO_KERNEL-1:0];
wire[31:0] out_pool2[NO_KERNEL-1:0];

wire[31:0] pixel_convert;
wire val_o_convert;

reg[3:0] count_k0, count_k1, count_k2, count_k3, count_k4, count_k5, count_w;


////////////////////////////////////////////////
//                                            //
//        CONVERT INT RGB TO FP GRAY          //
//                                            //
////////////////////////////////////////////////
RGB2Gray convert0(val_o_convert, pixel_convert, pixel_R, pixel_G, pixel_B, clk, rst_n, valid_in);


////////////////////////////////////////////////
//                                            //
//               STORE KERNELS                //
//                                            //
////////////////////////////////////////////////
genvar sk0, sk1, sk2, sk3, sk4, sk5;
generate
    for(sk0=0; sk0<9*NO_KERNEL; sk0=sk0+1) begin
        if(sk0==0) nbit_dff#(32) storage_k0(k0[sk0], ker0, clk, rst_n, load_k0);
        else nbit_dff#(32) storage_k0(k0[sk0], k0[sk0-1], clk, rst_n, load_k0);
    end
endgenerate

generate
    for(sk1=0; sk1<9*NO_KERNEL*NO_KERNEL1; sk1=sk1+1) begin
        if(sk1==0) nbit_dff#(32) storage_k1(k1[sk1], ker1, clk, rst_n, load_k1);
        else nbit_dff#(32) storage_k1(k1[sk1], k0[sk1-1], clk, rst_n, load_k1);
    end
endgenerate

generate
    for(sk2=0; sk2<9*NO_KERNEL1*NO_KERNEL2; sk2=sk2+1) begin
        if(sk2==0) nbit_dff#(32) storage_k2(k2[sk2], ker1, clk, rst_n, load_k2);
        else nbit_dff#(32) storage_k2(k2[sk2], k0[sk2-1], clk, rst_n, load_k2);
    end
endgenerate

generate
    for(sk3=0; sk3<9*NO_KERNEL2*NO_KERNEL3; sk3=sk3+1) begin
        if(sk3==0) nbit_dff#(32) storage_k3(k3[sk3], ker1, clk, rst_n, load_k3);
        else nbit_dff#(32) storage_k3(k3[sk3], k0[sk3-1], clk, rst_n, load_k3);
    end
endgenerate

generate
    for(sk4=0; sk4<9*NO_KERNEL3*NO_KERNEL4; sk4=sk4+1) begin
        if(sk4==0) nbit_dff#(32) storage_k4(k4[sk4], ker1, clk, rst_n, load_k4);
        else nbit_dff#(32) storage_k4(k4[sk4], k0[sk4-1], clk, rst_n, load_k4);
    end
endgenerate

generate
    for(sk5=0; sk5<9*NO_KERNEL4*NO_KERNEL5; sk5=sk5+1) begin
        if(sk5==0) nbit_dff#(32) storage_k5(k5[sk5], ker1, clk, rst_n, load_k5);
        else nbit_dff#(32) storage_k5(k5[sk5], k0[sk5-1], clk, rst_n, load_k5);
    end
endgenerate


////////////////////////////////////////////////
//                                            //
//               CNN GENERATOR                //
//                                            //
////////////////////////////////////////////////
genvar j;
generate    
    for(j=0; j<NO_KERNEL; j=j+1) begin
        convolmulti#(32,32,0,1) conv(val_o[j], out_conv[j], clk, rst_n, 1'b1, val_o_convert, pixel_convert,
                                     k0[j*NO_KERNEL-j], k0[j*NO_KERNEL+1-j], k0[j*NO_KERNEL+2-j], k0[j*NO_KERNEL+3-j], k0[j*NO_KERNEL+4-j],
                                     k0[j*NO_KERNEL+5-j], k0[j*NO_KERNEL+6-j], k0[j*NO_KERNEL+7-j], k0[j*NO_KERNEL+8-j]);
    end
endgenerate

genvar i, z;
generate
    for(i=0; i<NO_KERNEL; i=i+1) begin
         for(z=0; z<NO_KERNEL1; z=z+1) begin
            convolmulti#(32,30,0,0) conv1(val_o2[i*NO_KERNEL1+z], out_conv2[i*NO_KERNEL1+z], clk, rst_n, 1'b1, val_o[0], out_conv[i],
                                          k1[i*9*NO_KERNEL1+z*9], k1[i*9*NO_KERNEL1+z*9+1], k1[i*9*NO_KERNEL1+z*9+2], k1[i*9*NO_KERNEL1+z*9+3], k1[i*9*NO_KERNEL1+z*9+4],
                                          k1[i*9*NO_KERNEL1+z*9+5], k1[i*9*NO_KERNEL1+z*9+6], k1[i*9*NO_KERNEL1+z*9+7], k1[i*9*NO_KERNEL1+z*9+8]);
         end
    end
endgenerate

genvar i2;
generate
    for(i2=0; i2<NO_KERNEL1; i2=i2+1) begin
        add_10_inputs add0(val_o_add0[i2], out_add0[i2], out_conv2[i2*NO_KERNEL1], out_conv2[i2*NO_KERNEL1+1], out_conv2[i2*NO_KERNEL1+2], out_conv2[i2*NO_KERNEL1+3], out_conv2[i2*NO_KERNEL1+4],
                           out_conv2[i2*NO_KERNEL1+5], out_conv2[i2*NO_KERNEL1+6], out_conv2[i2*NO_KERNEL1+7], out_conv2[i2*NO_KERNEL1+8], out_conv2[i2*NO_KERNEL1]+9, val_o2[0]);
        pooling_Block#(32, 28) pool0(val_o_pool0[i2], out_pool0[i2], out_add0[i2], clk, rst_n, val_o_add0[0]);
    end
endgenerate

genvar x, y;
generate
    for(x=0; x<NO_KERNEL1; x=x+1) begin
         for(y=0; y<NO_KERNEL2; y=y+1) begin
            convolmulti#(32,14,0,0) conv2(val_o3[x*NO_KERNEL2+y], out_conv3[x*NO_KERNEL2+y], clk, rst_n, 1'b1, val_o_pool0[0], out_pool0[x],
                                          k2[x*9*NO_KERNEL2+y*9], k2[x*9*NO_KERNEL2+y*9+1], k2[x*9*NO_KERNEL2+y*9+2], k2[x*9*NO_KERNEL2+y*9+3], k2[x*9*NO_KERNEL2+y*9+4],
                                          k2[x*9*NO_KERNEL2+y*9+5], k2[x*9*NO_KERNEL2+y*9+6], k2[x*9*NO_KERNEL2+y*9+7], k2[x*9*NO_KERNEL2+y*9+8]);
         end
    end
endgenerate

genvar q, w;
generate
    for(q=0; q<NO_KERNEL2; q=q+1) begin
         for(w=0; w<NO_KERNEL3; w=w+1) begin
            convolmulti#(32,12,0,0) conv3(val_o4[q*NO_KERNEL3+w], out_conv4[q*NO_KERNEL3+w], clk, rst_n, 1'b1, val_o4[0], out_conv3[q],
                                          k3[q*9*NO_KERNEL3+w*9], k3[q*9*NO_KERNEL3+w*9+1], k3[q*9*NO_KERNEL3+w*9+2], k3[q*9*NO_KERNEL3+w*9+3], k3[q*9*NO_KERNEL3+w*9+4],
                                          k3[q*9*NO_KERNEL3+w*9+5], k3[q*9*NO_KERNEL3+w*9+6], k3[q*9*NO_KERNEL3+w*9+7], k3[q*9*NO_KERNEL3+w*9+8]);
         end
    end
endgenerate

genvar i3;
generate
    for(i3=0; i3<NO_KERNEL2; i3=i3+1) begin
        add_10_inputs add1(val_o_add1[i3], out_add1[i3], out_conv4[i3*NO_KERNEL2], out_conv4[i3*NO_KERNEL2+1], out_conv4[i3*NO_KERNEL2+2], out_conv4[i3*NO_KERNEL2+3], out_conv4[i3*NO_KERNEL2+4],
                           out_conv4[i3*NO_KERNEL2+5], out_conv4[i3*NO_KERNEL2+6], out_conv4[i3*NO_KERNEL2+7], out_conv4[i3*NO_KERNEL2+8], out_conv4[i3*NO_KERNEL2]+9, val_o4[0]);
        pooling_Block#(32, 10) pool1(val_o_pool1[i3], out_pool0[i3], out_add1[i3], clk, rst_n, val_o_add1[0]);
    end
endgenerate

genvar e, r;
generate
    for(e=0; e<NO_KERNEL3; e=e+1) begin
         for(r=0; r<NO_KERNEL4; r=r+1) begin
            convolmulti#(32,5,0,0) conv4(val_o5[e*NO_KERNEL4+r], out_conv5[e*NO_KERNEL4+r], clk, rst_n, 1'b1, val_o_pool1[0], out_pool0[0],
                                          k4[e*9*NO_KERNEL4+r*9], k4[e*9*NO_KERNEL4+r*9+1], k4[e*9*NO_KERNEL4+r*9+2], k4[e*9*NO_KERNEL4+r*9+3], k4[e*9*NO_KERNEL4+r*9+4],
                                          k4[e*9*NO_KERNEL4+r*9+5], k4[e*9*NO_KERNEL4+r*9+6], k4[e*9*NO_KERNEL4+r*9+7], k4[e*9*NO_KERNEL4+r*9+8]);
         end
    end
endgenerate

genvar u, v;
generate
    for(u=0; u<NO_KERNEL4; u=u+1) begin
         for(v=0; v<NO_KERNEL5; v=v+1) begin
            convolmulti#(32,3,0,0) conv5(val_o6[u*NO_KERNEL5+v], out_conv6[u*NO_KERNEL5+v], clk, rst_n, 1'b1, val_o6[0], out_conv5[u],
                                          k5[u*9*NO_KERNEL5+v*9], k5[u*9*NO_KERNEL5+v*9+1], k5[u*9*NO_KERNEL5+v*9+2], k5[u*9*NO_KERNEL5+v*9+3], k5[u*9*NO_KERNEL5+v*9+4],
                                          k5[u*9*NO_KERNEL5+v*9+5], k5[u*9*NO_KERNEL5+v*9+6], k5[u*9*NO_KERNEL5+v*9+7], k5[u*9*NO_KERNEL5+v*9+8]);
         end
    end
endgenerate


////////////////////////////////////////////////
//                                            //
//              FULLY CONNECTED               //
//                                            //
////////////////////////////////////////////////
Perceptron_v0(
    valid_out,
    predict0,
    out_conv6[0], out_conv6[1], out_conv6[2], out_conv6[3], out_conv6[4],
    out_conv6[5], out_conv6[6], out_conv6[7], out_conv6[8], out_conv6[9],
    w0_0,
    clk, rst_n, val_o6[0], load_w
    );

Perceptron_v0(
    ,
    predict1,
    out_conv6[0], out_conv6[1], out_conv6[2], out_conv6[3], out_conv6[4],
    out_conv6[5], out_conv6[6], out_conv6[7], out_conv6[8], out_conv6[9],
    w0_1,
    clk, rst_n, val_o6[0], load_w
    );


////////////////////////////////////////////////
//                                            //
//               GEN LOAD DONE                //
//                                            //
////////////////////////////////////////////////
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count_k0 <= 'd0;
    end
    else begin
        if(load_k0) begin
            if(count_k0 < 'd90) begin
                count_k0 <= count_k0 + 1'b1;
            end
        end
        else begin
            count_k0 <= 'd0;
        end
    end
end
assign load_k0_done = (count_k0=='d90)?1'b1:1'b0;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count_k1 <= 'd0;
    end
    else begin
        if(load_k1) begin
            if(count_k1 < 'd900) begin
                count_k1 <= count_k1 + 1'b1;
            end
        end
        else begin
            count_k1 <= 'd0;
        end
    end
end
assign load_k1_done = (count_k1=='d900)?1'b1:1'b0;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count_k2 <= 'd0;
    end
    else begin
        if(load_k2) begin
            if(count_k2 < 'd900) begin
                count_k2 <= count_k2 + 1'b1;
            end
        end
        else begin
            count_k2 <= 'd0;
        end
    end
end
assign load_k2_done = (count_k2=='d900)?1'b1:1'b0;


always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count_k3 <= 'd0;
    end
    else begin
        if(load_k3) begin
            if(count_k3 < 'd900) begin
                count_k3 <= count_k3 + 1'b1;
            end
        end
        else begin
            count_k3 <= 'd0;
        end
    end
end
assign load_k3_done = (count_k3=='d900)?1'b1:1'b0;


always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count_k4 <= 'd0;
    end
    else begin
        if(load_k4) begin
            if(count_k4 < 'd900) begin
                count_k4 <= count_k4 + 1'b1;
            end
        end
        else begin
            count_k4 <= 'd0;
        end
    end
end
assign load_k4_done = (count_k4=='d900)?1'b1:1'b0;


always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count_k5 <= 'd0;
    end
    else begin
        if(load_k5) begin
            if(count_k5 < 'd900) begin
                count_k5 <= count_k5 + 1'b1;
            end
        end
        else begin
            count_k5 <= 'd0;
        end
    end
end
assign load_k5_done = (count_k5=='d900)?1'b1:1'b0;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count_w <= 'd0;
    end
    else begin
        if(load_w) begin
            if(count_w < 'd10) begin
                count_w <= count_w + 1'b1;
            end
        end
        else begin
            count_w <= 'd0;
        end
    end
end
assign load_w_done = (count_w=='d10)?1'b1:1'b0;

endmodule
