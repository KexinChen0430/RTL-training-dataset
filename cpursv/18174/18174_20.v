
module oh_ser2par  #(parameter  PW = 64, SW = 1, CW = $clog2(PW*(1/SW)))
  (input  clk,
   input  [(-1)+SW:0] din,
   output reg [(-1)+PW:0] dout,
   input  lsbfirst,
   input  shift);

  reg  [CW-1:0] count;
  wire [(-1)+PW:0] shiftdata;

  
  always @(posedge clk)
      if (shift & lsbfirst) dout[(-1)+PW:0] <= {din[(-1)+SW:0],dout[(-1)+PW:SW]};
      else if (shift) dout[(-1)+PW:0] <= {dout[((0-SW)+PW)-1:0],din[(-1)+SW:0]};
        
endmodule

