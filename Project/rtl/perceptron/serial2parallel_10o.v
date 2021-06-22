`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2021 10:14:58 AM
// Design Name: 
// Module Name: serial2parallel
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


module serial2parallel_10o(
    output done,
    output[31:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9,
    input[31:0] in,
    input clk, rst_n, start
    );

nbit_dff#(32) ff0(out9, in, clk, rst_n, start);    
nbit_dff#(32) ff1(out8, out9, clk, rst_n, start);
nbit_dff#(32) ff2(out7, out8, clk, rst_n, start);
nbit_dff#(32) ff3(out6, out7, clk, rst_n, start);
nbit_dff#(32) ff4(out5, out6, clk, rst_n, start);
nbit_dff#(32) ff5(out4, out5, clk, rst_n, start);
nbit_dff#(32) ff6(out3, out4, clk, rst_n, start);
nbit_dff#(32) ff7(out2, out3, clk, rst_n, start);
nbit_dff#(32) ff8(out1, out2, clk, rst_n, start);
nbit_dff#(32) ff9(out0, out1, clk, rst_n, start);

Clock_Delay#(1, 10) delay(done, start, clk, rst_n, start);

endmodule
