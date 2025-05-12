
module rotate  #(parameter  C_DIRECTION = LEFT, C_WIDTH = 4)
  (input  [(0-1)+C_WIDTH:0] WR_DATA,
   input  [clog2s(C_WIDTH)+(0-1):0] WR_SHIFTAMT,
   output [(0-1)+C_WIDTH:0] RD_DATA);

  wire [C_WIDTH<<1-1:0] wPreShiftR;
  wire [C_WIDTH<<1-1:0] wPreShiftL;
  wire [C_WIDTH<<1-1:0] wShiftR;
  wire [C_WIDTH<<1-1:0] wShiftL;

  assign wPreShiftL = {WR_DATA,WR_DATA};
  assign wPreShiftR = {WR_DATA,WR_DATA};
  assign wShiftL = wPreShiftL<<<WR_SHIFTAMT;
  assign wShiftR = wPreShiftR>>WR_SHIFTAMT;
  
  generate
      if (C_DIRECTION == LEFT) 
        begin
          assign RD_DATA = wShiftL[C_WIDTH<<1-1:C_WIDTH];
        end
      else if (C_DIRECTION == RIGHT) 
        begin
          assign RD_DATA = wShiftR[(0-1)+C_WIDTH:0];
        end
        
  endgenerate

endmodule

