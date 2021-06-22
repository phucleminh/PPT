`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2020 02:00:43 PM
// Design Name: 
// Module Name: tb
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


module tb2(

    );

wire valid_out;
wire[31:0] predict0, predict1;
wire load_k0_done, load_k1_done, load_k2_done, load_k3_done, load_k4_done, load_k5_done, load_w_done;
reg[7:0] pixel_R, pixel_G, pixel_B;
reg[31:0] ker0, ker1, ker2, ker3, ker4, ker5;
reg[31:0] w0_0, w0_1;
reg clk, rst_n, valid_in, load_k0, load_k1, load_k2, load_k3, load_k4, load_k5, load_w;

dut2#(
    10,
    10,
    10,
    10,
    10,
    10
)inst(
    valid_out,
    predict0,
    predict1,
    load_k0_done, load_k1_done, load_k2_done, load_k3_done, load_k4_done, load_k5_done, load_w_done,
    pixel_R, pixel_G, pixel_B,
    ker0, ker1, ker2, ker3, ker4, ker5,
    w0_0, w0_1,
    clk, rst_n, valid_in, load_k0, load_k1, load_k2, load_k3, load_k4, load_k5, load_w
);

initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

integer i, j, z, l, m, n;
integer file_k0, file_k1, file_k2, file_k3, file_k4, file_k5;
reg[800:0] read_k0, read_k1, read_k2, read_k3, read_k4, read_k5;

integer c, d;
integer file_w0_0, file_w0_1;

reg[800:0] read_w0_0, read_w0_1;



integer imgR, imgG, imgB;
integer i2;
reg[800:0] read_imgR, read_imgG, read_imgB;
initial begin
    rst_n = 1'b0;
    load_k0 = 1'b0;
    load_k1 = 1'b0;
    load_k2 = 1'b0;
    load_k3 = 1'b0;
    load_k4 = 1'b0;
    load_k5 = 1'b0;
    load_w = 1'b0;
    valid_in = 1'b0;

    repeat(10) @(posedge clk);
    rst_n = 1'b1;
    repeat(2) @(posedge clk);
    
    load_k0 = 1'b1;
    file_k0 = $fopen("kernel0.txt", "r");
    while(load_k0_done != 1) begin
        @(posedge clk);
        $fgets(read_k0, file_k0);
        $sscanf(read_k0, "%b", ker0);
        
    end
    $fclose(file_k0);
    load_k0 = 1'b0;
    
    load_k1 = 1'b1;
    file_k1 = $fopen("kernel1.txt", "r");
    while(load_k1_done != 1) begin
        @(posedge clk);
        $fgets(read_k1, file_k1);
        $sscanf(read_k1, "%b", ker1);
        
    end
    $fclose(file_k1);
    load_k1 = 1'b0;
    
    load_k2 = 1'b1;
    file_k2 = $fopen("kernel2.txt", "r");
    while(load_k2_done != 1) begin
        @(posedge clk);
        $fgets(read_k2, file_k2);
        $sscanf(read_k2, "%b", ker2);
        
    end
    $fclose(file_k2);
    load_k2 = 1'b0;
    
    load_k3 = 1'b1;
    file_k3 = $fopen("kernel3.txt", "r");
    while(load_k3_done != 1) begin
        @(posedge clk);
        $fgets(read_k3, file_k3);
        $sscanf(read_k3, "%b", ker3);
        
    end
    $fclose(file_k3);
    load_k3 = 1'b0;
    
    load_k4 = 1'b1;
    file_k4 = $fopen("kernel4.txt", "r");
    while(load_k4_done != 1) begin
        @(posedge clk);
        $fgets(read_k4, file_k4);
        $sscanf(read_k4, "%b", ker4);
        
    end
    $fclose(file_k4);
    load_k4 = 1'b0;
    
    load_k5 = 1'b1;
    file_k5 = $fopen("kernel5.txt", "r");
    while(load_k5_done != 1) begin
        @(posedge clk);
        $fgets(read_k5, file_k5);
        $sscanf(read_k5, "%b", ker5);
        
    end
    $fclose(file_k5);
    load_k5 = 1'b0;
    
    load_w = 1'b1;
    file_w0_0 = $fopen("w0_0.txt", "r");
    file_w0_1 = $fopen("w0_1.txt", "r");
    while(load_w_done != 1) begin
        @(posedge clk);
        $fgets(read_w0_0, file_w0_0);
        $sscanf(read_w0_0, "%b", w0_0);
        $fgets(read_w0_1, file_w0_1);
        $sscanf(read_w0_1, "%b", w0_1);
    end
    $fclose(file_w0_0);
    $fclose(file_w0_1);
    load_w = 1'b0;

    repeat(16) @(posedge clk);
    
    imgR = $fopen("datasetR.txt", "r");
    imgG = $fopen("datasetG.txt", "r");
    imgB = $fopen("datasetB.txt", "r");
    @(posedge clk);                    
    $fgets(read_imgR, imgR);             
    $sscanf(read_imgR, "%d", pixel_R);
    $fgets(read_imgG, imgG);             
    $sscanf(read_imgG, "%d", pixel_G);
    $fgets(read_imgB, imgB);             
    $sscanf(read_imgB, "%d", pixel_B);
    @(posedge clk)
    valid_in = 1;
    for(i=0; i<553; i = i+1) begin
        for(i2=0; i2<1025; i2 = i2+1) begin
            @(posedge clk);
            $fgets(read_imgR, imgR);             
            $sscanf(read_imgR, "%d", pixel_R);
            $fgets(read_imgG, imgG);             
            $sscanf(read_imgG, "%d", pixel_G);
            $fgets(read_imgB, imgB);             
            $sscanf(read_imgB, "%d", pixel_B);
        end
    end
    $fclose(imgR);
    $fclose(imgG);
    $fclose(imgB);
end

endmodule
