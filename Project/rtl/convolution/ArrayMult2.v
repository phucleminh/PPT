`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:09 03/31/2021 
// Design Name: 
// Module Name:    ArrayMult2 
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
module ArrayMult2(
    output[47:0] prod,
    input[23:0] a, b,
    input clk, rst_n, start
);

reg[47:0] partial0_s1,  partial1_s1,  partial2_s1,
          partial3_s1,  partial4_s1,  partial5_s1,
          partial6_s1,  partial7_s1,  partial8_s1,
          partial9_s1,  partial10_s1, partial11_s1,
          partial12_s1, partial13_s1, partial14_s1,
          partial15_s1, partial16_s1, partial17_s1,
          partial18_s1, partial19_s1, partial20_s1,
          partial21_s1, partial22_s1, partial23_s1;

reg[47:0] prod0_s2, prod1_s2, prod2_s2, prod3_s2,
          prod4_s2, prod5_s2, prod6_s2, prod7_s2;

reg[47:0] prod0_s3, prod1_s3, prod2_s3, prod3_s3;

reg[47:0] prod0_s4, prod1_s4;

reg[47:0] prod0_s5;

wire[47:0] prod0_w2, prod1_w2, prod2_w2, prod3_w2,
			  prod4_w2, prod5_w2, prod6_w2, prod7_w2;

assign prod = prod0_s5;

/*CSA#(48) csa0(, prod0_w2, partial0_s1, {partial1_s1[46:0], 1'b0}, {partial2_s1[45:0], 2'b0});
CSA#(48) csa1(, prod1_w2, partial3_s1, {partial4_s1[46:0], 1'b0}, {partial5_s1[45:0], 2'b0});
CSA#(48) csa2(, prod2_w2, partial6_s1, {partial7_s1[46:0], 1'b0}, {partial8_s1[45:0], 2'b0});
CSA#(48) csa3(, prod3_w2, partial9_s1, {partial10_s1[46:0], 1'b0}, {partial11_s1[45:0], 2'b0});
CSA#(48) csa4(, prod4_w2, partial12_s1, {partial13_s1[46:0], 1'b0}, {partial14_s1[45:0], 2'b0});
CSA#(48) csa5(, prod5_w2, partial15_s1, {partial16_s1[46:0], 1'b0}, {partial17_s1[45:0], 2'b0});
CSA#(48) csa6(, prod6_w2, partial18_s1, {partial19_s1[46:0], 1'b0}, {partial20_s1[45:0], 2'b0});
CSA#(48) csa7(, prod7_w2, partial21_s1, {partial22_s1[46:0], 1'b0}, {partial23_s1[45:0], 2'b0});*/

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        partial0_s1  <= 'd0; partial1_s1  <= 'd0; partial2_s1  <= 'd0;
        partial3_s1  <= 'd0; partial4_s1  <= 'd0; partial5_s1  <= 'd0;
        partial6_s1  <= 'd0; partial7_s1  <= 'd0; partial8_s1  <= 'd0;
        partial9_s1  <= 'd0; partial10_s1 <= 'd0; partial11_s1 <= 'd0;
        partial12_s1 <= 'd0; partial13_s1 <= 'd0; partial14_s1 <= 'd0;
        partial15_s1 <= 'd0; partial16_s1 <= 'd0; partial17_s1 <= 'd0;
        partial18_s1 <= 'd0; partial19_s1 <= 'd0; partial20_s1 <= 'd0;
        partial21_s1 <= 'd0; partial22_s1 <= 'd0; partial23_s1 <= 'd0;

        prod0_s2 <= 'd0; prod1_s2 <= 'd0; prod2_s2 <= 'd0; prod3_s2 <= 'd0;
        prod4_s2 <= 'd0; prod5_s2 <= 'd0; prod6_s2 <= 'd0; prod7_s2 <= 'd0;

        prod0_s3 <= 'd0; prod1_s3 <= 'd0; prod2_s3 <= 'd0; prod3_s3 <= 'd0;

        prod0_s4 <= 'd0; prod1_s4 <= 'd0;

        prod0_s5 <= 'd0;
    end
    else begin
        if(start) begin
            //STAGE 1//
            partial0_s1  <= a & {24{b[0]}};
            partial1_s1  <= a & {24{b[1]}};
            partial2_s1  <= a & {24{b[2]}};
            partial3_s1  <= a & {24{b[3]}};
            partial4_s1  <= a & {24{b[4]}};
            partial5_s1  <= a & {24{b[5]}};
            partial6_s1  <= a & {24{b[6]}};
            partial7_s1  <= a & {24{b[7]}};
            partial8_s1  <= a & {24{b[8]}};
            partial9_s1  <= a & {24{b[9]}};
            partial10_s1 <= a & {24{b[10]}};
            partial11_s1 <= a & {24{b[11]}};
            partial12_s1 <= a & {24{b[12]}};
            partial13_s1 <= a & {24{b[13]}};
            partial14_s1 <= a & {24{b[14]}};
            partial15_s1 <= a & {24{b[15]}};
            partial16_s1 <= a & {24{b[16]}};
            partial17_s1 <= a & {24{b[17]}};
            partial18_s1 <= a & {24{b[18]}};
            partial19_s1 <= a & {24{b[19]}};
            partial20_s1 <= a & {24{b[20]}};
            partial21_s1 <= a & {24{b[21]}};
            partial22_s1 <= a & {24{b[22]}};
            partial23_s1 <= a & {24{b[23]}};

            //STAGE 2//
            prod0_s2 <= partial0_s1 + {partial1_s1[46:0], 1'b0} + {partial2_s1[45:0], 2'b0};
            prod1_s2 <= partial3_s1 + {partial4_s1[46:0], 1'b0} + {partial5_s1[45:0], 2'b0};
            prod2_s2 <= partial6_s1 + {partial7_s1[46:0], 1'b0} + {partial8_s1[45:0], 2'b0};
            prod3_s2 <= partial9_s1 + {partial10_s1[46:0], 1'b0} + {partial11_s1[45:0], 2'b0};
            prod4_s2 <= partial12_s1 + {partial13_s1[46:0], 1'b0} + {partial14_s1[45:0], 2'b0};
            prod5_s2 <= partial15_s1 + {partial16_s1[46:0], 1'b0} + {partial17_s1[45:0], 2'b0};
            prod6_s2 <= partial18_s1 + {partial19_s1[46:0], 1'b0} + {partial20_s1[45:0], 2'b0};
            prod7_s2 <= partial21_s1 + {partial22_s1[46:0], 1'b0} + {partial23_s1[45:0], 2'b0};

            //STAGE 3//
            prod0_s3 <= prod0_s2 + {prod1_s2[44:0], 3'b0};
            prod1_s3 <= prod2_s2 + {prod3_s2[44:0], 3'b0};
            prod2_s3 <= prod4_s2 + {prod5_s2[44:0], 3'b0};
            prod3_s3 <= prod6_s2 + {prod7_s2[44:0], 3'b0};

            //STAGE 4//
            prod0_s4 <= prod0_s3 + {prod1_s3[41:0], 6'b0};
            prod1_s4 <= prod2_s3 + {prod3_s3[41:0], 6'b0};
            
            //STAGE 5//
            prod0_s5 <= prod0_s4 + {prod1_s4[35:0], 12'b0};
        end
        else begin
            //STAGE 1//
            partial0_s1  <= partial0_s1;
            partial1_s1  <= partial1_s1;
            partial2_s1  <= partial2_s1;
            partial3_s1  <= partial3_s1;
            partial4_s1  <= partial4_s1;
            partial5_s1  <= partial5_s1;
            partial6_s1  <= partial6_s1;
            partial7_s1  <= partial7_s1;
            partial8_s1  <= partial8_s1;
            partial9_s1  <= partial9_s1;
            partial10_s1 <= partial10_s1;
            partial11_s1 <= partial11_s1;
            partial12_s1 <= partial12_s1;
            partial13_s1 <= partial13_s1;
            partial14_s1 <= partial14_s1;
            partial15_s1 <= partial15_s1;
            partial16_s1 <= partial16_s1;
            partial17_s1 <= partial17_s1;
            partial18_s1 <= partial18_s1;
            partial19_s1 <= partial19_s1;
            partial20_s1 <= partial20_s1;
            partial21_s1 <= partial21_s1;
            partial22_s1 <= partial22_s1;
            partial23_s1 <= partial23_s1;

            //STAGE 2//
            prod0_s2 <= prod0_s2;
            prod1_s2 <= prod1_s2;
            prod2_s2 <= prod2_s2;
            prod3_s2 <= prod3_s2;
            prod4_s2 <= prod4_s2;
            prod5_s2 <= prod5_s2;
            prod6_s2 <= prod6_s2;
            prod7_s2 <= prod7_s2;

            //STAGE 3//
            prod0_s3 <= prod0_s3;
            prod1_s3 <= prod1_s3;
            prod2_s3 <= prod2_s3;
            prod3_s3 <= prod3_s3;

            //STAGE 4//
            prod0_s4 <= prod0_s4;
            prod1_s4 <= prod1_s4;
            
            //STAGE 5//
            prod0_s5 <= prod0_s5;
        end
    end
end


endmodule
