
module jt51_dac2  #(parameter  width = 16)
  (input  clk,
   input  rst,
   input  signed  [width+(-1):0] din,
   output reg dout);

  parameter  int_w = 5+width;
  reg  [int_w-1:0] y,error,error_1,error_2;
  wire [width+(-1):0]  undin = {~din[width+(-1)],din[(0-1<<<1)+width:0]};

  
  always @(*)
      begin
        y <= (0-error_2)+(undin+{error_1,1'b0});
        dout <= ~y[int_w-1];
        error <= y-{dout,{width{1'b0}}};
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

