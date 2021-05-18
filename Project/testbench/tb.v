`timescale 1ns/1ps

module tb();
   wire valid_out_gray;
   wire[7:0] out_gray;
   wire valid_out_conv;
   wire[7:0] out_conv;
   wire valid_out_relu;
   wire[7:0] out_relu;
   wire valid_out_pool;
   wire[7:0] out_pool;
   reg[7:0] R, G, B;
   reg[31:0] w0, w1, w2, w3, w4, w5, w6, w7, w8;
   reg clk, rst_n, valid_in;

   dut inst(valid_out_gray, out_gray, valid_out_conv, out_conv, valid_out_relu, out_relu, valid_out_pool, out_pool, R, G, B, w0, w1, w2, w3, w4, w5, w6, w7, w8, clk, rst_n, valid_in);

   initial begin
      clk = 0;
      forever #5 clk = ~clk;
   end

   integer R_file;
   integer G_file;
   integer B_file;
   reg[800:0] R_line;
   reg[800:0] G_line;
   reg[800:0] B_line;
   integer i;
   initial begin
      rst_n = 0;
      valid_in = 0;
      w0 = 32'h00000000;
      w1 = 32'hbf800000;
      w2 = 32'h00000000;
      w3 = 32'hbf800000;
      w4 = 32'h40800000;
      w5 = 32'hbf800000;
      w6 = 32'h00000000;
      w7 = 32'hbf800000;
      w8 = 32'h00000000;
      
      repeat(10) @(posedge clk);
      rst_n = 1;
      @(posedge clk);
      R_file = $fopen("R.txt", "r");
      G_file = $fopen("G.txt", "r");
      B_file = $fopen("B.txt", "r");
      for(i=0; i<48400; i=i+1) begin
	  @(posedge clk);
	  valid_in = 1;
         $fgets(R_line, R_file);
	 $sscanf(R_line, "%d", R);
         $fgets(G_line, G_file);
	 $sscanf(G_line, "%d", G);
         $fgets(B_line, B_file);
	 $sscanf(B_line, "%d", B);
      end
      $fclose(R_file);
      $fclose(G_file);
      $fclose(B_file);
      #30000 $stop;
   end

   integer result_gray, result_conv, result_relu, result_pool;
   integer i1, i2, i3, i4;

   initial begin
      result_gray = $fopen("result_gray.txt", "w");
      for(i1=0; i1<48400;) begin
	     @(posedge clk);
         if(valid_out_gray) begin
	       $fdisplay(result_gray, "%0d", out_gray);
	       i1 = i1+1;
         end
      end
      $fclose(result_gray);
   end

   initial begin
      result_conv = $fopen("result_conv.txt", "w");
      for(i2=0; i2<47524;) begin
	     @(posedge clk);
         if(valid_out_conv) begin
	        $fdisplay(result_conv, "%0d", out_conv);
	        i2 = i2+1;
         end
      end
      $fclose(result_conv);
   end

   initial begin
      result_relu = $fopen("result_relu.txt", "w");
      for(i3=0; i3<47524;) begin
	     @(posedge clk);
         if(valid_out_relu) begin
	        $fdisplay(result_relu, "%0d", out_relu);
	        i3 = i3+1;
         end
      end
      $fclose(result_relu);
   end

   initial begin
      result_pool = $fopen("result_pool.txt", "w");
      for(i4=0; i4<11881;) begin
	     @(posedge clk);
         if(valid_out_pool) begin
	        $fdisplay(result_pool, "%0d", out_pool);
	        i4 = i4+1;
         end
      end
      $fclose(result_pool);
   end

endmodule