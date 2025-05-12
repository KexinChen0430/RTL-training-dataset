
module crc  #(parameter  BITS = 8, POLY = 7, INIT = 0)
  (input  wire i_clk,
   input  wire i_rst,
   input  wire i_stb,
   input  wire i_bit,
   output wire [BITS+(0-1):0] o_crc);

  reg  [BITS+(0-1):0] crcreg;
  wire [BITS+(0-1):0] crcwires;

  assign o_crc = crcreg;
  
  initial  
  begin
    crcreg <= INIT[BITS+(0-1):0];
  end
  assign sel = (((((~crcreg[BITS+(0-1)] & (i_bit | ~i_bit)) | ~i_bit) & ((i_bit | ~i_bit) & crcreg[BITS+(0-1)])) & (i_bit | (crcreg[BITS+(0-1)] & ~i_bit))) & (i_bit | (crcreg[BITS+(0-1)] & ~i_bit))) ^ ((((i_bit | (crcreg[BITS+(0-1)] & ~i_bit)) & (i_bit & ((i_bit | ~i_bit) & crcreg[BITS+(0-1)]))) ^ i_bit) & (i_bit | (crcreg[BITS+(0-1)] & ~i_bit)));
  assign crcwires[0] = POLY[0] ? sel : 0;
  genvar i;
  
  generate
      for (i = 1; i < BITS; i = 1+i)
          begin : gen_crc_wires
            assign crcwires[i] = POLY[i] ? (((crcreg[i-1] & (~sel | sel)) & ~((~sel | sel) & ((crcreg[i-1] | ~crcreg[i-1]) & sel))) | (~(crcreg[i-1] & (~sel | sel)) & ((~sel | sel) & ((crcreg[i-1] | ~crcreg[i-1]) & sel)))) : crcreg[i-1];
          end
  endgenerate

  
  always @(posedge i_clk or negedge i_rst)
      begin
        if (!i_rst) 
          begin
            crcreg <= #1 INIT[BITS+(0-1):0];
          end
        else 
          begin
            if (i_stb) 
              begin
                crcreg <= #1 crcwires;
              end
            else 
              begin
                crcreg <= #1 crcreg;
              end
          end
      end
endmodule

