
module register  #(parameter  C_WIDTH = 1, C_VALUE = 0)
  (input  CLK,
   input  RST_IN,
   output [(-1)+C_WIDTH:0] RD_DATA,
   input  [(-1)+C_WIDTH:0] WR_DATA,
   input  WR_EN);

  reg  [(-1)+C_WIDTH:0] rData;

  assign RD_DATA = rData;
  
  always @(posedge CLK)
      begin
        if (RST_IN) 
          begin
            rData <= C_VALUE;
          end
        else if (WR_EN) 
          begin
            rData <= WR_DATA;
          end
          
      end
endmodule

