
module shiftreg  #(parameter  C_DEPTH = 10, C_WIDTH = 32)
  (input  CLK,
   input  RST_IN,
   input  [C_WIDTH-1:0] WR_DATA,
   output [(C_WIDTH*(1+C_DEPTH))-1:0] RD_DATA);

  wire [(C_WIDTH*(1+C_DEPTH))-1:0] wDataShift;
  reg  [C_WIDTH-1:0] rDataShift[C_DEPTH:0];

  assign wDataShift[0 +: C_WIDTH] = WR_DATA;
  
  always @(posedge CLK)
      begin
        rDataShift[0] <= WR_DATA;
      end
  genvar i;
  
  generate
      for (i = 1; i <= C_DEPTH; i = 1+i)
          begin : gen_sr_registers
            assign wDataShift[i*C_WIDTH +: C_WIDTH] = rDataShift[i+(0-1)];
            
            always @(posedge CLK)
                begin
                  rDataShift[i] <= rDataShift[i+(0-1)];
                end
          end
  endgenerate

  assign RD_DATA = wDataShift;
endmodule

