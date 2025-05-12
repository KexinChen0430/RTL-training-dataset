
module rx_descrambler  #(parameter  DWIDTH = 16, BITSLIP_SHIFT_RIGHT = 1)
  (input  wire clk,
   input  wire res_n,
   input  wire bit_slip,
   input  wire can_lock,
   output reg locked,
   input  wire [DWIDTH-1:0] data_in,
   output reg [DWIDTH-1:0] data_out);

  reg  [14:0] lfsr;
  wire [14:0] lfsr_slipped;
  wire [14:0] lfsr_steps[DWIDTH-1:0];
  wire [14:0] calculated_seed;
  wire [DWIDTH-1:0] data_out_tmp;

  
  generate
      if (BITSLIP_SHIFT_RIGHT == 1) 
        begin
          assign lfsr_slipped = {(~lfsr_steps[DWIDTH-1][0] & lfsr_steps[DWIDTH-1][1]) | ((((~lfsr_steps[DWIDTH-1][1] | ~lfsr_steps[DWIDTH-1][0]) | lfsr_steps[DWIDTH-1][1]) & lfsr_steps[DWIDTH-1][0]) & (~lfsr_steps[DWIDTH-1][1] | ~lfsr_steps[DWIDTH-1][0])),lfsr_steps[DWIDTH-1][14:1]};
        end
      else 
        begin
          assign lfsr_slipped = {lfsr_steps[DWIDTH-1][13:0],((((lfsr_steps[DWIDTH-1][0] | (lfsr_steps[DWIDTH-1][14] & (lfsr_steps[DWIDTH-1][0] | ~lfsr_steps[DWIDTH-1][0]))) & ~lfsr_steps[DWIDTH-1][14]) | (~lfsr_steps[DWIDTH-1][14] | ~lfsr_steps[DWIDTH-1][0])) & (lfsr_steps[DWIDTH-1][0] & (~lfsr_steps[DWIDTH-1][14] | ~lfsr_steps[DWIDTH-1][0]))) ^ ((((lfsr_steps[DWIDTH-1][0] | (lfsr_steps[DWIDTH-1][14] & (lfsr_steps[DWIDTH-1][0] | ~lfsr_steps[DWIDTH-1][0]))) & ~lfsr_steps[DWIDTH-1][14]) | (~lfsr_steps[DWIDTH-1][14] | ~lfsr_steps[DWIDTH-1][0])) & (lfsr_steps[DWIDTH-1][14] & (~lfsr_steps[DWIDTH-1][14] | ~lfsr_steps[DWIDTH-1][0])))};
        end
  endgenerate

  
  always @(posedge clk)
      begin
        begin
          data_out <= data_out_tmp;
          if (!locked) 
            begin
              lfsr <= calculated_seed;
            end
          else 
            begin
              if (bit_slip) 
                begin
                  lfsr <= lfsr_slipped;
                end
              else 
                begin
                  lfsr <= lfsr_steps[DWIDTH-1];
                end
            end
        end
        if (!res_n) 
          begin
            locked <= 1'b0;
          end
        else 
          begin
            if (!locked) 
              begin
                if (calculated_seed == lfsr_steps[DWIDTH-1]) 
                  begin
                    locked <= 1'b1;
                  end
                  
              end
              
            if (!can_lock) 
              begin
                locked <= 1'b0;
              end
              
          end
      end
  genvar j;
  
  generate
      localparam  OFFSET = (0-15)+DWIDTH;

      assign calculated_seed[14] = 1'b1;
      for (j = 0; j < 14; j = 1+j)
          begin : seed_calc
            assign calculated_seed[j] = ((~data_in[1+(OFFSET+j)] | (data_in[OFFSET+j] | data_in[1+(OFFSET+j)])) & ((~data_in[OFFSET+j] | data_in[OFFSET+j]) & data_in[OFFSET+j])) ^ ((~data_in[1+(OFFSET+j)] | (data_in[OFFSET+j] | data_in[1+(OFFSET+j)])) & (data_in[1+(OFFSET+j)] & (~data_in[OFFSET+j] | data_in[OFFSET+j])));
          end
      assign data_out_tmp[0] = ((((data_in[0] | ~data_in[0]) & (data_in[0] | lfsr[0])) | (~lfsr[0] & ((data_in[0] | ~data_in[0]) & (data_in[0] | lfsr[0])))) & (lfsr[0] & (data_in[0] | ~data_in[0]))) ^ ((((data_in[0] | ~data_in[0]) & (data_in[0] | lfsr[0])) | (~lfsr[0] & ((data_in[0] | ~data_in[0]) & (data_in[0] | lfsr[0])))) & ((data_in[0] | ~data_in[0]) & data_in[0]));
      assign lfsr_steps[0] = {((((~lfsr[1] | lfsr[1]) | (~lfsr[1] & ((((data_in[0] | lfsr[0]) | ~lfsr[0]) & lfsr[1]) | lfsr[0]))) & (((data_in[0] | lfsr[0]) | ~lfsr[0]) & lfsr[1])) & ~(((~lfsr[1] | lfsr[1]) | (~lfsr[1] & ((((data_in[0] | lfsr[0]) | ~lfsr[0]) & lfsr[1]) | lfsr[0]))) & lfsr[0])) | (~(((~lfsr[1] | lfsr[1]) | (~lfsr[1] & ((((data_in[0] | lfsr[0]) | ~lfsr[0]) & lfsr[1]) | lfsr[0]))) & (((data_in[0] | lfsr[0]) | ~lfsr[0]) & lfsr[1])) & (((~lfsr[1] | lfsr[1]) | (~lfsr[1] & ((((data_in[0] | lfsr[0]) | ~lfsr[0]) & lfsr[1]) | lfsr[0]))) & lfsr[0])),lfsr[14:1]};
      for (j = 1; j < DWIDTH; j = 1+j)
          begin : scrambler_gen
            assign data_out_tmp[j] = lfsr_steps[j-1][0] ^ ((~lfsr_steps[j-1][0] | (lfsr_steps[j-1][0] | data_in[j])) & data_in[j]);
            assign lfsr_steps[j] = {(lfsr_steps[j-1][0] & ~lfsr_steps[j-1][1]) | ((~lfsr_steps[j-1][0] & ((~lfsr_steps[j-1][0] | (lfsr_steps[j-1][0] | data_in[j])) & (lfsr_steps[j-1][1] | lfsr_steps[j-1][0]))) & lfsr_steps[j-1][1]),lfsr_steps[j-1][14:1]};
          end
  endgenerate

endmodule

