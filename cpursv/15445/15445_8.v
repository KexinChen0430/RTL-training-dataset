
module shiftreg  #(parameter  C_DEPTH = 10, C_WIDTH = 32)
  (input  CLK,
   input  RST_IN,
   input  [C_WIDTH-1:0] WR_DATA,
   output [((1+C_DEPTH)*C_WIDTH)-1:0] RD_DATA);

  wire [((1+C_DEPTH)*C_WIDTH)-1:0] wDataShift;
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
            assign wDataShift[C_WIDTH*i +: C_WIDTH] = rDataShift[(-1)+i];
            
            always @(posedge CLK)
                begin
                  rDataShift[i] <= rDataShift[(-1)+i];
                end
          end
  endgenerate

  assign RD_DATA = wDataShift;
endmodule

