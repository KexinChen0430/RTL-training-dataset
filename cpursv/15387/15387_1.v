
module my_fifo_496(clk,din,dout,rdy);

  input  clk;
  input  [(0-1)+8:0] din;
  output [(0-1)+8:0] dout;
  reg  [(0-1)+8:0] dout;
  input  rdy;
  reg  [(0-1)+8:0] buff1;
  reg  [(0-1)+8:0] buff2;

  
  always @(posedge clk)
      begin
        if (rdy == 1'b1) 
          begin
            buff1 <= din;
            dout <= buff2;
            buff2 <= buff1;
          end
          
      end
endmodule

