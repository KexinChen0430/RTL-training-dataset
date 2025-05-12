
module sh_reg_1(clk,wen,din_1,dout_1);

  input  clk;
  input  wen;
  input  [(0-1)+8:0] din_1;
  output [(0-1)+8:0] dout_1;
  reg  [(0-1)+8:0] dout_1;

  
  always @(posedge clk)
      begin
        if (wen == 1'b1) 
          begin
            dout_1 <= din_1;
          end
          
      end
endmodule

