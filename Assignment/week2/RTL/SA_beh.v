module SA_beh(
output reg[47:0] prod,
input[23:0] a, b,
input clk, rst_n, start
    );

reg[47:0] a_s0,  a_s1,  a_s2,  a_s3,
			 a_s4,  a_s5,  a_s6,  a_s7,
			 a_s8,  a_s9,  a_s10, a_s11,
			 a_s12, a_s13, a_s14, a_s15,
			 a_s16, a_s17, a_s18, a_s19,
			 a_s20, a_s21, a_s22, a_s23,
			 a_s24;
			 
reg[23:0] b_s0,  b_s1,  b_s2,  b_s3,
			 b_s4,  b_s5,  b_s6,  b_s7,
			 b_s8,  b_s9,  b_s10, b_s11,
			 b_s12, b_s13, b_s14, b_s15,
			 b_s16, b_s17, b_s18, b_s19,
			 b_s20, b_s21, b_s22, b_s23,
			 b_s24;

wire[47:0] sum_s1,  sum_s2,  sum_s3,  sum_s4,
			  sum_s5,  sum_s6,  sum_s7,  sum_s8,
			  sum_s9,  sum_s10, sum_s11, sum_s12,
			  sum_s13, sum_s14, sum_s15, sum_s16,
			  sum_s17, sum_s18, sum_s19, sum_s20,
			  sum_s21, sum_s22, sum_s23, sum_s24;
			  
reg[47:0] prod_s1,  prod_s2,  prod_s3,  prod_s4,
			 prod_s5,  prod_s6,  prod_s7,  prod_s8,
			 prod_s9,  prod_s10, prod_s11, prod_s12,
			 prod_s13, prod_s14, prod_s15, prod_s16,
			 prod_s17, prod_s18, prod_s19, prod_s20,
			 prod_s21, prod_s22, prod_s23, prod_s24;

assign sum_s1 = 48'd0 + a_s0;
assign sum_s2 = prod_s1 + a_s1;
assign sum_s3 = prod_s2 + a_s2;
assign sum_s4 = prod_s3 + a_s3;
assign sum_s5 = prod_s4 + a_s4;
assign sum_s6 = prod_s5 + a_s5;
assign sum_s7 = prod_s6 + a_s6;
assign sum_s8 = prod_s7 + a_s7;
assign sum_s9 = prod_s8 + a_s8;
assign sum_s10 = prod_s9 + a_s9;
assign sum_s11 = prod_s10 + a_s10;
assign sum_s12 = prod_s11 + a_s11;
assign sum_s13 = prod_s12 + a_s12;
assign sum_s14 = prod_s13 + a_s13;
assign sum_s15 = prod_s14 + a_s14;
assign sum_s16 = prod_s15 + a_s15;
assign sum_s17 = prod_s16 + a_s16;
assign sum_s18 = prod_s17 + a_s17;
assign sum_s19 = prod_s18 + a_s18;
assign sum_s20 = prod_s19 + a_s19;
assign sum_s21 = prod_s20 + a_s20;
assign sum_s22 = prod_s21 + a_s21;
assign sum_s23 = prod_s22 + a_s22;
assign sum_s24 = prod_s23 + a_s23;

integer i;
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		a_s0 <= 48'd0; a_s1 <= 48'd0; a_s2 <= 48'd0; a_s3 <= 48'd0;
		a_s4 <= 48'd0; a_s5 <= 48'd0; a_s6 <= 48'd0; a_s7 <= 48'd0;
		a_s8 <= 48'd0; a_s9 <= 48'd0; a_s10 <= 48'd0; a_s11 <= 48'd0;
		a_s12 <= 48'd0; a_s13 <= 48'd0; a_s14 <= 48'd0; a_s15 <= 48'd0;
		a_s16 <= 48'd0; a_s17 <= 48'd0; a_s18 <= 48'd0; a_s19 <= 48'd0;
		a_s20 <= 48'd0; a_s21 <= 48'd0; a_s22 <= 48'd0; a_s23 <= 48'd0;
		a_s24 <= 48'd0;
		
		b_s0 <= 24'd0;  b_s1 <= 24'd0;  b_s2 <= 24'd0;  b_s3 <= 24'd0;
		b_s4 <= 24'd0;  b_s5 <= 24'd0;  b_s6 <= 24'd0;  b_s7 <= 24'd0;
		b_s8 <= 24'd0;  b_s9 <= 24'd0;  b_s10 <= 24'd0; b_s11 <= 24'd0;
		b_s12 <= 24'd0; b_s13 <= 24'd0; b_s14 <= 24'd0; b_s15 <= 24'd0;
		b_s16 <= 24'd0; b_s17 <= 24'd0; b_s18 <= 24'd0; b_s19 <= 24'd0;
		b_s24 <= 24'd0; b_s21 <= 24'd0; b_s22 <= 24'd0; b_s23 <= 24'd0;
		b_s24 <= 24'd0;
		
		prod_s1 <= 48'd0; prod_s2 <= 48'd0; prod_s3 <= 48'd0; prod_s4 <= 48'd0;
		prod_s5 <= 48'd0; prod_s6 <= 48'd0; prod_s7 <= 48'd0; prod_s8 <= 48'd0;
		prod_s9 <= 48'd0; prod_s10 <= 48'd0; prod_s11 <= 48'd0; prod_s12 <= 48'd0;
		prod_s13 <= 48'd0; prod_s14 <= 48'd0; prod_s15 <= 48'd0; prod_s16 <= 48'd0;
		prod_s17 <= 48'd0; prod_s18 <= 48'd0; prod_s19 <= 48'd0; prod_s20 <= 48'd0;
		prod_s21 <= 48'd0; prod_s22 <= 48'd0; prod_s23 <= 48'd0; prod_s24 <= 48'd0;
		
		prod <= 48'd0;
	end
	else begin
		if(start) begin
			a_s0 <= a;
			b_s0 <= b;
			//STAGE 1//
			if(b_s0[0] == 1'b1) prod_s1 <= sum_s1;
			else prod_s1 <= 48'b0;
			a_s1 <= a_s0<<1;
			b_s1 <= b_s0>>1;
			//STAGE 2//
			if(b_s1[0] == 1'b1) prod_s2 <= sum_s2;
			else prod_s2 <= prod_s1;
			a_s2 <= a_s1<<1;
			b_s2 <= b_s1>>1;
			//STAGE 3//
			if(b_s2[0] == 1'b1) prod_s3 <= sum_s3;
			else prod_s3 <= prod_s2;
			a_s3 <= a_s2<<1;
			b_s3 <= b_s2>>1;
			//STAGE 4//
			if(b_s3[0] == 1'b1) prod_s4 <= sum_s4;
			else prod_s4 <= prod_s3;
			a_s4 <= a_s3<<1;
			b_s4 <= b_s3>>1;
			//STAGE 5//
			if(b_s4[0] == 1'b1) prod_s5 <= sum_s5;
			else prod_s5 <= prod_s4;
			a_s5 <= a_s4<<1;
			b_s5 <= b_s4>>1;
			//STAGE 6//
			if(b_s5[0] == 1'b1) prod_s6 <= sum_s6;
			else prod_s6 <= prod_s5;
			a_s6 <= a_s5<<1;
			b_s6 <= b_s5>>1;
			//STAGE 7//
			if(b_s6[0] == 1'b1) prod_s7 <= sum_s7;
			else prod_s7 <= prod_s6;
			a_s7 <= a_s6<<1;
			b_s7 <= b_s6>>1;
			//STAGE 8//
			if(b_s7[0] == 1'b1) prod_s8 <= sum_s8;
			else prod_s8 <= prod_s7;
			a_s8 <= a_s7<<1;
			b_s8 <= b_s7>>1;
			//STAGE 9//
			if(b_s8[0] == 1'b1) prod_s9 <= sum_s9;
			else prod_s9 <= prod_s8;
			a_s9 <= a_s8<<1;
			b_s9 <= b_s8>>1;
			//STAGE 10//
			if(b_s9[0] == 1'b1) prod_s10 <= sum_s10;
			else prod_s10 <= prod_s9;
			a_s10 <= a_s9<<1;
			b_s10 <= b_s9>>1;
			//STAGE 11//
			if(b_s10[0] == 1'b1) prod_s11 <= sum_s11;
			else prod_s11 <= prod_s10;
			a_s11 <= a_s10<<1;
			b_s11 <= b_s10>>1;
			//STAGE 12//
			if(b_s11[0] == 1'b1) prod_s12 <= sum_s12;
			else prod_s12 <= prod_s11;
			a_s12 <= a_s11<<1;
			b_s12 <= b_s11>>1;
			//STAGE 13//
			if(b_s12[0] == 1'b1) prod_s13 <= sum_s13;
			else prod_s13 <= prod_s12;
			a_s13 <= a_s12<<1;
			b_s13 <= b_s12>>1;
		  	//STAGE 14//
			if(b_s13[0] == 1'b1) prod_s14 <= sum_s14;
			else prod_s14 <= prod_s13;
			a_s14 <= a_s13<<1;
			b_s14 <= b_s13>>1;
			//STAGE 15//
			if(b_s14[0] == 1'b1) prod_s15 <= sum_s15;
			else prod_s15 <= prod_s14;
			a_s15 <= a_s14<<1;
			b_s15 <= b_s14>>1;
			//STAGE 16//
			if(b_s15[0] == 1'b1) prod_s16 <= sum_s16;
			else prod_s16 <= prod_s15;
			a_s16 <= a_s15<<1;
			b_s16 <= b_s15>>1;
			//STAGE 17//
			if(b_s16[0] == 1'b1) prod_s17 <= sum_s17;
			else prod_s17 <= prod_s16;
			a_s17 <= a_s16<<1;
			b_s17 <= b_s16>>1;
			//STAGE 18//
			if(b_s17[0] == 1'b1) prod_s18 <= sum_s18;
			else prod_s18 <= prod_s17;
			a_s18 <= a_s17<<1;
			b_s18 <= b_s17>>1;
			//STAGE 19//
			if(b_s18[0] == 1'b1) prod_s19 <= sum_s19;
			else prod_s19 <= prod_s18;
			a_s19 <= a_s18<<1;
			b_s19 <= b_s18>>1;
			//STAGE 20//
			if(b_s19[0] == 1'b1) prod_s20 <= sum_s20;
			else prod_s20 <= prod_s19;
			a_s20 <= a_s19<<1;
			b_s20 <= b_s19>>1;
			//STAGE 21//
			if(b_s20[0] == 1'b1) prod_s21 <= sum_s21;
			else prod_s21 <= prod_s20;
			a_s21 <= a_s20<<1;
			b_s21 <= b_s20>>1;
			//STAGE 22//
			if(b_s21[0] == 1'b1) prod_s22 <= sum_s22;
			else prod_s22 <= prod_s21;
			a_s22 <= a_s21<<1;
			b_s22 <= b_s21>>1;
			//STAGE 23//
			if(b_s22[0] == 1'b1) prod_s23 <= sum_s23;
			else prod_s23 <= prod_s22;
			a_s23 <= a_s22<<1;
			b_s23 <= b_s22>>1;
			//STAGE 24//
			if(b_s23[0] == 1'b1) prod_s24 <= sum_s24;
			else prod_s24 <= prod_s23;
			a_s24 <= a_s23<<1;
			b_s24 <= b_s23>>1;
			//STAGE OUTPUT//
			prod <= prod_s24;
		end
	end
end

endmodule
