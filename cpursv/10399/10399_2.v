
module crc  #(parameter  BITS = 8, POLY = 7, INIT = 0)
  (input  wire i_clk,
   input  wire i_rst,
   input  wire i_stb,
   input  wire i_bit,
   output wire [(-1)+BITS:0] o_crc);

  reg  [(-1)+BITS:0] crcreg;
  wire [(-1)+BITS:0] crcwires;

  assign o_crc = crcreg;
  
  initial  
  begin
    crcreg <= INIT[(-1)+BITS:0];
  end
  assign sel = (i_bit & (((~crcreg[(-1)+BITS] & ((i_bit | ~i_bit) & crcreg[(-1)+BITS])) | (~crcreg[(-1)+BITS] & i_bit)) | (~crcreg[(-1)+BITS] | ((~crcreg[(-1)+BITS] & i_bit) | crcreg[(-1)+BITS])))) ^ (crcreg[(-1)+BITS] & (((~crcreg[(-1)+BITS] & ((i_bit | ~i_bit) & crcreg[(-1)+BITS])) | (~crcreg[(-1)+BITS] & i_bit)) | (~crcreg[(-1)+BITS] | ((~crcreg[(-1)+BITS] & i_bit) | crcreg[(-1)+BITS]))));
  assign crcwires[0] = POLY[0] ? sel : 0;
  genvar i;
  
  generate
      for (i = 1; i < BITS; i = i+1)
          begin : gen_crc_wires
            assign crcwires[i] = POLY[i] ? ((crcreg[(-1)+i] & ~sel) | (((crcreg[(-1)+i] & sel) & (~sel | sel)) ^ sel)) : crcreg[(-1)+i];
          end
  endgenerate

  
  always @(posedge i_clk or negedge i_rst)
      begin
        if (!i_rst) 
          begin
            crcreg <= #1 INIT[(-1)+BITS:0];
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

