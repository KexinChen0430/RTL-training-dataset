
module sh_reg(clk,wen,din_1,din_2,dout_1,dout_2);

  parameter  sh_reg_w = 4'b1000;
  input  clk;
  input  wen;
  input  [(-1)+sh_reg_w:0] din_1;
  input  [(-1)+sh_reg_w:0] din_2;
  output [(-1)+sh_reg_w:0] dout_1;
  reg  [(-1)+sh_reg_w:0] dout_1;
  output [(-1)+sh_reg_w:0] dout_2;
  reg  [(-1)+sh_reg_w:0] dout_2;

  
  always @(posedge clk)
      begin
        if (wen == 1'b1) 
          begin
            dout_1 <= din_1;
            dout_2 <= din_2;
          end
        else 
          begin
            dout_1 <= dout_1;
            dout_2 <= dout_2;
          end
      end
endmodule

