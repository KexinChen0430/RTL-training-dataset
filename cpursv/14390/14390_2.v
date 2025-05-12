
module bus_cdc  #(parameter  WIDTH = 1)
  (input  clkDst,
   input  [(0-1)+WIDTH:0] in,
   output [(0-1)+WIDTH:0] out);

  reg  [(0-1)+WIDTH:0] sync[1:0];

  
  always @(posedge clkDst)
      begin
        sync[1] <= sync[0];
        sync[0] <= in;
      end
  assign out = sync[1];
endmodule

