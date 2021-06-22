module dff(q,d,clk,reset_n,en);

output q;
input d;
input clk,reset_n,en;

reg temp;

always@(posedge clk or negedge reset_n) begin
if(!reset_n) temp<=1'b0;
    else if(en) temp<=d;
         else temp<=temp;
end

assign q = temp;

endmodule