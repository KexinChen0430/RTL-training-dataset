
module counter_load(clk,rst,clk_ena,load,carry,dfload);

  parameter  MOD_COUNT = 7;
  parameter  WIDTH = 8;
  input  clk,rst,clk_ena;
  input  load;
  input  [WIDTH+(0-1):0] dfload;
  output carry;
  reg  carry_tmp;

  assign carry = carry_tmp;
  reg  [WIDTH+(0-1):0] count;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) count <= 0;
        else if (clk_ena) 
          if (load) count <= dfload;
          else count <= count+1;
          
      end
  
  always @(count)
      begin
        if (count == ((0-1)+MOD_COUNT)) carry_tmp = 'b1;
        else carry_tmp = 'b0;
      end
endmodule

