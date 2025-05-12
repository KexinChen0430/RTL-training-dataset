
module two_bit_counter(dclk,rst,control);

  input  dclk;
  input  rst;
  output [1:0] control;
  reg  [1:0] count;

  
  always @(posedge dclk or posedge rst)
      begin
        if (rst == 1'b1) count <= {2{1'b0}};
        else count <= 1'b1+count;
      end
  assign control = count;
endmodule

