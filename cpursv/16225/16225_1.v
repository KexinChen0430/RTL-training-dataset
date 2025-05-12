
module ecc_dec_fix  #(parameter 
       TCQ           = 100,
       PAYLOAD_WIDTH = 64,
       CODE_WIDTH    = 72,
       DATA_WIDTH    = 64,
       DQ_WIDTH      = 72,
       ECC_WIDTH     = 8,
       nCK_PER_CLK   = 4)
  (rd_data,ecc_single,ecc_multiple,clk,rst,h_rows,phy_rddata,
                   correct_en,ecc_status_valid);

  input  clk;
  input  rst;
  input  [(ECC_WIDTH*CODE_WIDTH)-1:0] h_rows;
  input  [(DQ_WIDTH*nCK_PER_CLK<<<1)+(0-1):0] phy_rddata;
  wire [(0-1)+(1<<<1*(nCK_PER_CLK*ECC_WIDTH)):0] syndrome_ns;

  genvar k;
  genvar m;
  
  generate
      for (k = 0; k < nCK_PER_CLK<<<1; k = k+1)
          begin : ecc_word
            for (m = 0; m < ECC_WIDTH; m = m+1)
                begin : ecc_bit
                  assign syndrome_ns[m+(k*ECC_WIDTH)] = ^(phy_rddata[DQ_WIDTH*k +: CODE_WIDTH] & h_rows[CODE_WIDTH*m +: CODE_WIDTH]);
                end
          end
  endgenerate

  reg  [(0-1)+(1<<<1*(nCK_PER_CLK*ECC_WIDTH)):0] syndrome_r;

  
  always @(posedge clk)
      syndrome_r <= #TCQ syndrome_ns;
  wire [(0-1)+(PAYLOAD_WIDTH*nCK_PER_CLK<<<1):0] ecc_rddata_ns;

  genvar i;
  
  generate
      for (i = 0; i < nCK_PER_CLK<<<1; i = i+1)
          begin : extract_payload
            assign ecc_rddata_ns[PAYLOAD_WIDTH*i +: PAYLOAD_WIDTH] = phy_rddata[DQ_WIDTH*i +: PAYLOAD_WIDTH];
          end
  endgenerate

  reg  [(0-1)+(PAYLOAD_WIDTH*nCK_PER_CLK<<<1):0] ecc_rddata_r;

  
  always @(posedge clk)
      ecc_rddata_r <= #TCQ ecc_rddata_ns;
  genvar n;
  genvar p;
  wire [ECC_WIDTH-1:0] h_matrix[DATA_WIDTH+(0-1):0];

  
  generate
      for (n = 0; n < DATA_WIDTH; n = n+1)
          begin : h_col
            for (p = 0; p < ECC_WIDTH; p = 1+p)
                begin : h_bit
                  assign h_matrix[n][p] = h_rows[n+(CODE_WIDTH*p)];
                end
          end
  endgenerate

  wire [(0-1)+((1<<<1*DATA_WIDTH)*nCK_PER_CLK):0] flip_bits;

  genvar q;
  genvar r;
  
  generate
      for (q = 0; q < nCK_PER_CLK<<<1; q = 1+q)
          begin : flip_word
            for (r = 0; r < DATA_WIDTH; r = 1+r)
                begin : flip_bit
                  assign flip_bits[(DATA_WIDTH*q)+r] = h_matrix[r] == syndrome_r[q*ECC_WIDTH +: ECC_WIDTH];
                end
          end
  endgenerate

  output reg [(0-1)+(PAYLOAD_WIDTH*nCK_PER_CLK<<<1):0] rd_data;

  input  correct_en;

  integer s;

  
  always @(correct_en or ecc_rddata_r or flip_bits)
      for (s = 0; s < nCK_PER_CLK<<<1; s = s+1)
          if (correct_en) 
            rd_data[PAYLOAD_WIDTH*s +: DATA_WIDTH] = (((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ((~((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & (flip_bits[s*DATA_WIDTH +: DATA_WIDTH] & ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]))) & ((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & flip_bits[s*DATA_WIDTH +: DATA_WIDTH])) | (((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & (flip_bits[s*DATA_WIDTH +: DATA_WIDTH] & ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]))) & ~((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & flip_bits[s*DATA_WIDTH +: DATA_WIDTH])))) & ~((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) & (~flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]))) & (((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]))))) | (~((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ((~((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & (flip_bits[s*DATA_WIDTH +: DATA_WIDTH] & ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]))) & ((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & flip_bits[s*DATA_WIDTH +: DATA_WIDTH])) | (((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & (flip_bits[s*DATA_WIDTH +: DATA_WIDTH] & ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]))) & ~((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & flip_bits[s*DATA_WIDTH +: DATA_WIDTH])))) & ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ((((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) & (~flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]))) & (((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ((flip_bits[s*DATA_WIDTH +: DATA_WIDTH] | ~flip_bits[s*DATA_WIDTH +: DATA_WIDTH]) & ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])) & ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH]) | (ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH] | ~ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH])))));
          else 
            rd_data[PAYLOAD_WIDTH*s +: DATA_WIDTH] = ecc_rddata_r[PAYLOAD_WIDTH*s +: DATA_WIDTH];
  localparam  RAW_BIT_WIDTH = PAYLOAD_WIDTH-DATA_WIDTH;

  genvar t;
  
  generate
      if (RAW_BIT_WIDTH > 0) 
        for (t = 0; t < nCK_PER_CLK<<<1; t = t+1)
            begin : copy_raw_bits
              
              always @(ecc_rddata_r)
                  rd_data[(0-1)+((t+1)*PAYLOAD_WIDTH) -: RAW_BIT_WIDTH] = ecc_rddata_r[(0-1)+((t+1)*PAYLOAD_WIDTH) -: RAW_BIT_WIDTH];
            end
        
  endgenerate

  input  ecc_status_valid;

  output wire [nCK_PER_CLK<<<1+(0-1):0] ecc_single;

  output wire [nCK_PER_CLK<<<1+(0-1):0] ecc_multiple;

  genvar v;
  
  generate
      for (v = 0; v < nCK_PER_CLK<<<1; v = 1+v)
          begin : compute_status
            wire  zero = ~|syndrome_r[ECC_WIDTH*v +: ECC_WIDTH];

            wire  odd = ^syndrome_r[ECC_WIDTH*v +: ECC_WIDTH];

            assign ecc_single[v] = odd && (ecc_status_valid && ~zero);
            assign ecc_multiple[v] = ~odd && (ecc_status_valid && ~zero);
          end
  endgenerate

endmodule

