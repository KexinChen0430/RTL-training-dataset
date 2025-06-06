
module jt51_dac2  #(parameter  width = 16)
  (input  clk,
   input  rst,
   input  signed  [width+(0-1):0] din,
   output reg dout);

  parameter  int_w = width+5;
  reg  [int_w-1:0] y,error,error_1,error_2;
  wire [width+(0-1):0]  undin = {~din[width+(0-1)],din[width-1<<<1:0]};

  
  always @(*)
      begin
        y <= ({error_1,1'b0}+undin)+(-error_2);
        dout <= ~y[int_w-1];
        error <= (0-{dout,{width{1'b0}}})+y;
      end
  
  always @(posedge clk)
      if (rst) 
        begin
          error_1 <= {int_w{1'b0}};
          error_2 <= {int_w{1'b0}};
        end
      else 
        begin
          error_1 <= error;
          error_2 <= error_1;
        end
endmodule

