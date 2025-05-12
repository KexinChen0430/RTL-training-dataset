
module oh_ser2par  #(parameter  PW = 64, SW = 1, CW = $clog2(PW/SW))
  (input  clk,
   input  [SW+(0-1):0] din,
   output reg [(0-1)+PW:0] dout,
   input  lsbfirst,
   input  shift);

  reg  [(0-1)+CW:0] count;
  wire [(0-1)+PW:0] shiftdata;

  
  always @(posedge clk)
      if (shift & lsbfirst) dout[(0-1)+PW:0] <= {din[SW+(0-1):0],dout[(0-1)+PW:SW]};
      else if (shift) dout[(0-1)+PW:0] <= {dout[(0-1)+(PW-SW):0],din[SW+(0-1):0]};
        
endmodule

