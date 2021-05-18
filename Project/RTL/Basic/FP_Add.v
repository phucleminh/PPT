`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:38 03/15/2021 
// Design Name: 
// Module Name:    FP_Add 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
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
wire[31:0] a_sync, b_sync;

//assign {sign_diff, diff} = exp_a - exp_b;
//assign sign_xor = sign_a ^ sign_b;
//assign {sign_sum , sum_mant} = sign_xor?(mant_a + mant_b):(mant_a - mant_b);

Clock_Delay#(32,6) sync_a(a_sync, a, clk, rst_n, start);
Clock_Delay#(32,6) sync_b(b_sync, b, clk, rst_n, start);
Clock_Delay#(1,7) u_delay_done(done, start, clk, rst_n, start);

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
			if(a_sync[30:0]=='d0) begin
			     sum_out <= b_sync;
			end
			else if(b_sync[30:0]=='d0) begin
			     sum_out <= a_sync;
			end
			else begin
                if(mant_s5[24]) begin
                    sum_out[22:0] <= mant_s5[23:1];
                    sum_out[30:23] <= exp_s5 + 1'b1;
                end
                else if(mant_s5[23]) begin
                        sum_out[22:0] <= mant_s5[22:0];
                        sum_out[30:23] <= exp_s5;
                      end
                      else
                      if(mant_s5[22]) begin
                        sum_out[22:0] <= {mant_s5[21:0], 1'b0};
                        sum_out[30:23] <= exp_s5 - 1'b1;
                      end
                      else 
                      if(mant_s5[21]) begin
                        sum_out[22:0] <= {mant_s5[20:0], 2'b0};
                        sum_out[30:23] <= exp_s5 - 2'd2;
                      end
                      else 
                      if(mant_s5[20]) begin
                        sum_out[22:0] <= {mant_s5[19:0], 3'b0};
                        sum_out[30:23] <= exp_s5 - 2'd3;
                      end
                      else 
                      if(mant_s5[19]) begin
                        sum_out[22:0] <= {mant_s5[18:0], 4'b0};
                        sum_out[30:23] <= exp_s5 - 3'd4;
                      end
                      else 
                      if(mant_s5[18]) begin
                        sum_out[22:0] <= {mant_s5[17:0], 5'b0};
                        sum_out[30:23] <= exp_s5 - 3'd5;
                      end
                      else 
                      if(mant_s5[17]) begin
                        sum_out[22:0] <= {mant_s5[16:0], 6'b0};
                        sum_out[30:23] <= exp_s5 - 3'd6;
                      end
                      else 
                      if(mant_s5[16]) begin
                        sum_out[22:0] <= {mant_s5[15:0], 7'b0};
                        sum_out[30:23] <= exp_s5 - 3'd7;
                      end
                      else 
                      if(mant_s5[15]) begin
                        sum_out[22:0] <= {mant_s5[14:0], 8'b0};
                        sum_out[30:23] <= exp_s5 - 4'd8;
                      end
                      else 
                      if(mant_s5[14]) begin
                        sum_out[22:0] <= {mant_s5[13:0], 9'b0};
                        sum_out[30:23] <= exp_s5 - 4'd9;
                      end
                      else 
                      if(mant_s5[13]) begin
                        sum_out[22:0] <= {mant_s5[12:0], 10'b0};
                        sum_out[30:23] <= exp_s5 - 4'd10;
                      end
                      else 
                      if(mant_s5[12]) begin
                        sum_out[22:0] <= {mant_s5[11:0], 11'b0};
                        sum_out[30:23] <= exp_s5 - 4'd11;
                      end
                      else 
                      if(mant_s5[11]) begin
                        sum_out[22:0] <= {mant_s5[10:0], 12'b0};
                        sum_out[30:23] <= exp_s5 - 4'd12;
                      end
                      else 
                      if(mant_s5[10]) begin
                        sum_out[22:0] <= {mant_s5[9:0], 13'b0};
                        sum_out[30:23] <= exp_s5 - 4'd13;
                      end
                      else 
                      if(mant_s5[9]) begin
                        sum_out[22:0] <= {mant_s5[8:0], 14'b0};
                        sum_out[30:23] <= exp_s5 - 4'd14;
                      end
                      else 
                      if(mant_s5[8]) begin
                        sum_out[22:0] <= {mant_s5[7:0], 15'b0};
                        sum_out[30:23] <= exp_s5 - 4'd15;
                      end
                      else 
                      if(mant_s5[7]) begin
                        sum_out[22:0] <= {mant_s5[6:0], 16'b0};
                        sum_out[30:23] <= exp_s5 - 5'd16;
                      end
                      else 
                      if(mant_s5[6]) begin
                        sum_out[22:0] <= {mant_s5[5:0], 17'b0};
                        sum_out[30:23] <= exp_s5 - 5'd17;
                      end
                      else 
                      if(mant_s5[5]) begin
                        sum_out[22:0] <= {mant_s5[4:0], 18'b0};
                        sum_out[30:23] <= exp_s5 - 5'd18;
                      end
                      else 
                      if(mant_s5[4]) begin
                        sum_out[22:0] <= {mant_s5[3:0], 19'b0};
                        sum_out[30:23] <= exp_s5 - 5'd19;
                      end
                      else 
                      if(mant_s5[3]) begin
                        sum_out[22:0] <= {mant_s5[2:0], 20'b0};
                        sum_out[30:23] <= exp_s5 - 5'd20;
                      end
                      else 
                      if(mant_s5[2]) begin
                        sum_out[22:0] <= {mant_s5[1:0], 21'b0};
                        sum_out[30:23] <= exp_s5 - 5'd21;
                      end
                      else 
                      if(mant_s5[1]) begin
                        sum_out[22:0] <= {mant_s5[0], 22'b0};
                        sum_out[30:23] <= exp_s5 - 5'd22;
                      end
                      else 
                      begin
                        sum_out[22:0] <= 23'b0;
                        sum_out[30:23] <= exp_s5 - 5'd23;
                      end
                sum_out[31] <= sign_s5;
            end
		end
		else begin
		    sign_a <= sign_a;  sign_b <= sign_b;
            exp_a  <= exp_a;  exp_b  <= exp_b;
            mant_a <= mant_a; mant_b <= mant_b;
            
            sign_diff <= sign_diff; diff <= diff;
            exp_a_s1 <= exp_a_s1; exp_b_s1 <= exp_b_s1;
            mant_a_s1 <= mant_a_s1; mant_b_s1 <= mant_b_s1;
            sign_a_s1 <= sign_a_s1; sign_b_s1 <= sign_b_s1;
            
            sum_exp_a <= sum_exp_a; sum_exp_b <= sum_exp_b;
            mant_a_sh_s2 <= mant_a_sh_s2; mant_a_s2 <= mant_a_s2;
            mant_b_sh_s2 <= mant_b_sh_s2; mant_b_s2 <= mant_b_s2;
            exp_a_s2 <= exp_a_s2; exp_b_s2 <= exp_b_s2;
            sign_a_s2 <= sign_a_s2; sign_b_s2 <= sign_b_s2;
            sign_diff_s2 <= sign_diff_s2; diff_s2 <= diff_s2;
            
            mant_a_s3 <= mant_a_s3; mant_b_s3 <= mant_b_s3;
            exp_s3 <= exp_s3;
            sign_a_s3 <= sign_a_s3; sign_b_s3 <= sign_b_s3;
            sign_diff_s3 <= sign_diff_s3; diff_s3 <= diff_s3;
            
            sum <= sum;
            sub <= sub; sign_sub <= sign_sub;
            sign_a_xor_sign_b <= sign_a_xor_sign_b;
            exp_s4 <= exp_s4; sign_diff_s4 <= sign_diff_s4;
            diff_s4 <= diff_s4; 
            sign_a_s4 <= sign_a_s4; sign_b_s4 <= sign_b_s4;
            
            mant_s5 <= mant_s5; 
            exp_s5 <= exp_s5;
            sign_s5 <= sign_s5;
            
            sum_out <= sum_out;
		end
	end
end

endmodule
