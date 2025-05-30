
module counter_load_out(clk,rst,clk_ena,load,carry,dfload,dout);

  parameter  MOD_COUNT = 7;
  parameter  WIDTH = 8;
  input  clk,rst,clk_ena;
  input  load;
  input  [(0-1)+WIDTH:0] dfload;
  output carry;
  reg  carry_tmp;

  assign carry = carry_tmp;
  reg  [(0-1)+WIDTH:0] count;

  output [(0-1)+WIDTH:0] dout;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) count <= 0;
        else if (clk_ena) 
          if (load) count <= dfload;
          else count <= 1+count;
          
      end
  
  always @(count)
      begin
        if (count == (MOD_COUNT+(0-1))) carry_tmp = 'b1;
        else carry_tmp = 'b0;
      end
  assign dout = count;
endmodule

