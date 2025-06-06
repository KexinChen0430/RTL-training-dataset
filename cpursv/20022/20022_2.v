
module f5_NonBlockingEx(clk,merge,er,xmit,fddi,claim);

  input  clk,merge,er,xmit,fddi;
  output reg claim;
  reg  fcr;

  
  always @(posedge clk)
      begin
        fcr = xmit | er;
        if (merge) claim = fcr & fddi;
        else claim = fddi;
      end
endmodule

