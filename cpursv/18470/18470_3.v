
module counter_load_down(clk,rst,clk_ena,load,carry,dfload);

  parameter  MOD_COUNT = 4;
  parameter  WIDTH = 4;
  input  clk,rst,clk_ena;
  input  load;
  input  [WIDTH+(-1):0] dfload;
  output carry;
  reg  carry_tmp;

  assign carry = carry_tmp;
  reg  [WIDTH+(-1):0] count;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) count <= 0;
        else if (clk_ena) 
          if (load) count <= dfload;
          else count <= count+(-1);
          
      end
  
  always @(count)
      begin
        if (count == 0) carry_tmp = 1'b1;
        else carry_tmp = 1'b0;
      end
endmodule

