module tb(
    );
wire done;
wire[31:0] Gray;
reg[31:0] R, G, B;
reg clk, rst_n, start;
	 
RGB2Gray inst(done, Gray, R, G, B, clk, rst_n, start);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

integer readR, readG, readB;
integer write_img;
integer i, j;
reg[800:0] getLineR, getLineG, getLineB;
initial begin
	R = 32'b0;
	G = 32'b0;
	B = 32'b0;
	
	rst_n = 0;
	start = 0;
	repeat(2) @(negedge clk)
	rst_n = 1;
	repeat(2) @(negedge clk)
	start = 1;
end

initial begin
	readR  = $fopen("R_FP.txt","r");
	readG  = $fopen("G_FP.txt","r");
	readB  = $fopen("B_FP.txt","r");
	@(posedge start);
	i = 1023;
	@(posedge clk);
	while(i>=0) begin
		$fgets(getLineR, readR);
		$sscanf(getLineR,"%b",R);
		$fgets(getLineG, readG);
		$sscanf(getLineG,"%b",G);
		$fgets(getLineB, readB);
		$sscanf(getLineB,"%b",B);
		i = i-1;
		@(posedge clk);
	end
	
	$fclose(readR);
	$fclose(readG);
	$fclose(readB);
end

initial begin
	write_img  = $fopen("img_rtl_out.txt","w");

	j = 1023;
	@(posedge done);
	@(posedge clk);
	while(j>=0) begin
		$fdisplay(write_img,"%b",Gray);
		j = j-1;
		@(posedge clk);
	end
	
	$fclose(write_img);
end

initial begin
	@(posedge done);
	repeat(2000) @(posedge clk);
	$stop;
end

endmodule
