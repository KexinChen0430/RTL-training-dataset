
module partsel_test007(input  [31:-32] din,
                       input  signed  [4:0] n,
                       output reg [31:-32] dout);

  
  always @(*)
      begin
        dout = 0;
        dout[1+n] = din[n];
      end
endmodule

