module FP_Add(
output done,
output reg[31:0] sum_out,
input[31:0] a, b,
input clk, rst_n, start
    );

reg sign_a, sign_b;
reg[7:0] exp_a, exp_b;
reg[24:0] mant_a, mant_b;

reg sign_diff, sign_a_s1, sign_b_s1, sign_a_s2, sign_b_s2, sign_diff_s2, sign_a_s3, sign_b_s3,
	 sign_diff_s3, sign_sub, sign_a_xor_sign_b, sign_diff_s4, sign_a_s4, sign_b_s4, sign_s5;
	 
reg[7:0] diff, exp_a_s1, exp_b_s1, sum_exp_a, sum_exp_b, exp_a_s2, exp_b_s2, diff_s2,
			exp_s3, diff_s3, exp_s4, diff_s4, exp_s5;
			
reg[24:0] mant_a_s1, mant_b_s1, mant_a_sh_s2, mant_a_s2, mant_b_sh_s2, mant_b_s2, mant_a_s3,
			 mant_b_s3, sum, sub, mant_s5;
wire[31:0] is_equal = a ^ b;
wire[7:0] diff_tmp;
wire diff_tmp_cout;
assign {diff_tmp_cout, diff_tmp} = exp_a - exp_b;
wire[7:0] diff_n = ~diff_tmp;
wire[7:0] diff_2s = diff_n + 1'b1;
wire[7:0] diff_o = diff_tmp_cout?diff_2s:diff_tmp;

//assign {sign_diff, diff} = exp_a - exp_b;
//assign sign_xor = sign_a ^ sign_b;
//assign {sign_sum , sum_mant} = sign_xor?(mant_a + mant_b):(mant_a - mant_b);

Clock_Delay#(1,7) u_delay_done(done, 1'b1, clk, rst_n, start);

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		sign_a <= 1'b0;  sign_b <= 1'b0;
		exp_a  <= 8'b0;  exp_b  <= 8'b0;
		mant_a <= 23'b0; mant_b <= 23'b0;
		
		sign_diff <= 1'b0; diff <= 8'b0;
		exp_a_s1 <= 8'b0; exp_b_s1 <= 8'b0;
		mant_a_s1 <= 24'b0; mant_b_s1 <= 24'b0;
		sign_a_s1 <= 1'b0; sign_b_s1 <= 1'b0;
		
		sum_exp_a <= 8'b0; sum_exp_b <= 8'b0;
		mant_a_sh_s2 <= 24'b0; mant_a_s2 <= 24'b0;
		mant_b_sh_s2 <= 24'b0; mant_b_s2 <= 24'b0;
		exp_a_s2 <= 8'b0; exp_b_s2 <= 8'b0;
		sign_a_s2 <= 1'b0; sign_b_s2 <= 1'b0;
		sign_diff_s2 <= 1'b0; diff_s2 <= 8'b0;
		
		mant_a_s3 <= 24'b0; mant_b_s3 <= 24'b0;
		exp_s3 <= 8'b0;
		sign_a_s3 <= 1'b0; sign_b_s3 <= 1'b0;
		sign_diff_s3 <= 1'b0; diff_s3 <= 8'b0;
		
		sum <= 24'b0;
		sub <= 24'b0; sign_sub <= 1'b0;
		sign_a_xor_sign_b <= 1'b0;
		exp_s4 <= 8'b0; sign_diff_s4 <= 1'b0;
		diff_s4 <= 8'b0; 
		sign_a_s4 <= 1'b0; sign_b_s4 <= 1'b0;
		
		mant_s5 <= 24'b0; 
		exp_s5 <= 8'b0;
		sign_s5 <= 1'b0;
		
		sum_out <= 32'b0;
		
	end
	else begin
		if(start) begin
			//STAGE 0//
			if(is_equal != {1'b1, 31'b0}) begin
				sign_a <= a[31];    sign_b <= b[31];
				exp_a  <= a[30:23]; exp_b  <= b[30:23];
				mant_a <= {2'b01, a[22:0]};  mant_b <= {2'b01, b[22:0]};
			end
			else begin
				sign_a <= 1'b0;    sign_b <= 1'b0;
				exp_a  <= 8'b0; exp_b  <= 8'b0;
				mant_a <= 25'b0;  mant_b <= 25'b0;
			end
			//STAGE 1//
			diff <= diff_o;
			sign_diff <= diff_tmp_cout;
			exp_a_s1 <= exp_a;
			exp_b_s1 <= exp_b;
			mant_a_s1 <= mant_a;
			mant_b_s1 <= mant_b;
			sign_a_s1 <= sign_a;
			sign_b_s1 <= sign_b;
		
			//STAGE 2//
			sum_exp_a <= exp_a_s1 + diff;
			sum_exp_b <= exp_b_s1 + diff;
			mant_a_sh_s2 <= mant_a_s1 >> diff;
			mant_a_s2 <= mant_a_s1;
			mant_b_sh_s2 <= mant_b_s1 >> diff;
			mant_b_s2 <= mant_b_s1;
		
			exp_a_s2 <= exp_a_s1;
			exp_b_s2 <= exp_b_s1;
		
			sign_a_s2 <= sign_a_s1;
			sign_b_s2 <= sign_b_s1;
		
			sign_diff_s2 <= sign_diff;
			diff_s2 <= diff;
		
			//STAGE 3//
			if(sign_diff_s2) begin
				mant_a_s3 <= mant_a_sh_s2;
				mant_b_s3 <= mant_b_s2;
				exp_s3 <= exp_b_s2;
			end
			else begin
				if(diff_s2 == 8'b0) begin
					mant_a_s3 <= mant_a_s2;
					mant_b_s3 <= mant_b_s2;
					exp_s3 <= exp_b_s2;
				end
				else begin
					mant_a_s3 <= mant_a_s2;
					mant_b_s3 <= mant_b_sh_s2;
					exp_s3 <= exp_a_s2;			
				end
			end
			sign_a_s3 <= sign_a_s2;
			sign_b_s3 <= sign_b_s2;
			sign_diff_s3 <= sign_diff_s2;
			diff_s3 <= diff_s2;
			
			//STAGE 4//
			sum <= mant_a_s3 + mant_b_s3;
			{sign_sub, sub} <= mant_a_s3 - mant_b_s3;
			sign_a_xor_sign_b <= sign_a_s3 ^ sign_b_s3;
			exp_s4 <= exp_s3;
			sign_diff_s4 <= sign_diff_s3;
			diff_s4 <= diff_s3;
			sign_a_s4 <= sign_a_s3;
			sign_b_s4 <= sign_b_s3;
				
			//STAGE 5//
			if(sign_a_xor_sign_b) begin
				if(sign_sub == 1'b1)
					mant_s5 <= ~sub+1'b1;
				else
					mant_s5 <= sub;
				exp_s5 <= exp_s4;
				if(sign_diff_s4) begin
					sign_s5 <= sign_b_s4;
				end
				else begin
					if(diff_s4 == 8'b0) begin
						if(sign_sub) sign_s5 <= sign_b_s4;
						else sign_s5 <= sign_a_s4;
					end
					else begin
						sign_s5 <= sign_a_s4;
					end
				end
			end
			else begin
				sign_s5 <= sign_a_s4;
				exp_s5 <= exp_s4;
				mant_s5 <= sum;
			end
			
			//STAGE 6 - OUTPUT//
			if(mant_s5[24]) begin
				sum_out[22:0] <= mant_s5[23:1];
				sum_out[30:23] <= exp_s5+1'b1;
			end
			else begin
				sum_out[22:0] <= mant_s5[22:0];
				sum_out[30:23] <= exp_s5;
			end
			sum_out[31] <= sign_s5;
		end
	end
end

endmodule
