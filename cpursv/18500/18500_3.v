
module counters_mod_rtl(clk,rst,clk_ena,q,carry);

  parameter  ADDR_MOD = 9;
  parameter  ADDR_WIDTH = 9;
  input  clk,clk_ena,rst;
  output [(0-1)+ADDR_WIDTH:0] q;
  output carry;
  reg  [(0-1)+ADDR_WIDTH:0] cnt;
  reg  carry_tmp;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) cnt <= 0;
        else if (clk_ena) 
          if (carry_tmp) cnt <= 0;
          else cnt <= 1+cnt;
          
      end
  
  always @(cnt)
      begin
        if (cnt == (ADDR_MOD+(0-1))) carry_tmp = 'b1;
        else carry_tmp = 'b0;
      end
  assign q = cnt;
  assign carry = carry_tmp;
endmodule

