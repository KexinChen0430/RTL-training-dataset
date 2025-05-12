
module oh_ser2par  #(parameter  PW = 64, SW = 1, CW = $clog2(PW/SW))
  (input  clk,
   input  [SW-1:0] din,
   output reg [(-1)+PW:0] dout,
   input  lsbfirst,
   input  shift);

  reg  [(-1)+CW:0] count;
  wire [(-1)+PW:0] shiftdata;

  
  always @(posedge clk)
      if (shift & lsbfirst) dout[(-1)+PW:0] <= {din[SW-1:0],dout[(-1)+PW:SW]};
      else if (shift) dout[(-1)+PW:0] <= {dout[PW+((-1)+(0-SW)):0],din[SW-1:0]};
        
endmodule

