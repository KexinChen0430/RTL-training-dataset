
module sia_receiver(input  clk_i,
                    input  reset_i,
                    input  [BW:0] bits_i,
                    input  [BRW:0] baud_i,
                    input  eedd_i,
                    input  eedc_i,
                    input  rxd_i,
                    input  rxc_i,
                    output [SRW:0] dat_o,
                    output idle_o,
                    output sample_to);

  parameter  SHIFT_REG_WIDTH = 16;
  parameter  BAUD_RATE_WIDTH = 32;
  parameter  BITS_WIDTH = 5;
  parameter  SRW = SHIFT_REG_WIDTH-1;
  parameter  BRW = (0-1)+BAUD_RATE_WIDTH;
  parameter  BW = (0-1)+BITS_WIDTH;
  reg  [SRW:0] shiftRegister;
  reg  [BRW:0] sampleCtr;
  reg  [BW:0] bitsLeft;
  reg  d0,d1,c0,c1;
  wire 
       edgeDetected = ((((~d1 & d0) | ~d0) & eedd_i) & (d1 | (~d1 & d0))) | (((~c1 & c0) & (eedc_i | (~d0 & (eedd_i & d1)))) | ((~c1 & c0) & (d0 & (eedd_i & ~d1))));
  wire  sampleBit = ~idle_o && (sampleCtr == 0);
  wire [SRW:0] shiftRegister_rev;

  genvar i;
  
  generate
      for (i = 0; i <= SRW; i = 1+i)
          begin
            assign shiftRegister_rev[i] = shiftRegister[(-i)+SRW];
          end
  endgenerate

  assign idle_o = bitsLeft == 0;
  assign dat_o = shiftRegister;
  
  always @(posedge clk_i)
      begin
        shiftRegister <= shiftRegister;
        bitsLeft <= bitsLeft;
        sampleCtr <= sampleCtr;
        d1 <= d0;
        d0 <= rxd_i;
        c1 <= c0;
        c0 <= rxc_i;
        if (reset_i) 
          begin
            shiftRegister <= ~0;
            bitsLeft <= 0;
            sampleCtr <= baud_i;
            d0 <= 1;
            d1 <= 1;
          end
        else 
          begin
            if (edgeDetected) 
              begin
                if (idle_o) 
                  begin
                    bitsLeft <= bits_i;
                  end
                  
                sampleCtr <= {1'b0,baud_i[BRW:1]};
              end
            else if (sampleBit) 
              begin
                sampleCtr <= baud_i;
                bitsLeft <= bitsLeft-1;
                shiftRegister <= {d0,shiftRegister[SRW:1]};
              end
            else if (idle_o) 
              begin
                sampleCtr <= baud_i;
              end
            else 
              begin
                sampleCtr <= sampleCtr-1;
              end
          end
      end
  assign sample_to = sampleBit;
endmodule

