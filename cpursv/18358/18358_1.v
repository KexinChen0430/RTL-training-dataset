
module fifo496(clk,wen,din,dout);

  parameter  WIDTH = 4'b1000;
  input  clk;
  input  wen;
  input  [(0-1)+WIDTH:0] din;
  output [(0-1)+WIDTH:0] dout;
  reg  [(0-1)+WIDTH:0] dout;
  reg  [(0-1)+WIDTH:0] buff1;
  reg  [(0-1)+WIDTH:0] buff2;

  
  always @(posedge clk)
      begin
        if (wen == 1'b1) 
          begin
            buff1 <= din;
            buff2 <= buff1;
            dout <= buff2;
          end
          
      end
endmodule

