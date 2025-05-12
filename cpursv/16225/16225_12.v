
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
  input  [(-1)+(DQ_WIDTH*nCK_PER_CLK<<<1):0] phy_rddata;
  wire [(-1)+(nCK_PER_CLK<<<1*ECC_WIDTH):0] syndrome_ns;

  genvar k;
  genvar m;
  
  generate
      for (k = 0; k < nCK_PER_CLK<<<1; k = k+1)
          begin : ecc_word
            for (m = 0; m < ECC_WIDTH; m = 1+m)
                begin : ecc_bit
                  assign syndrome_ns[(k*ECC_WIDTH)+m] = ^(phy_rddata[k*DQ_WIDTH +: CODE_WIDTH] & h_rows[CODE_WIDTH*m +: CODE_WIDTH]);
                end
          end
  endgenerate

  reg  [(-1)+(nCK_PER_CLK<<<1*ECC_WIDTH):0] syndrome_r;

  
  always @(posedge clk)
      syndrome_r <= #TCQ syndrome_ns;
  wire [(1<<<1*(PAYLOAD_WIDTH*nCK_PER_CLK))-1:0] ecc_rddata_ns;

  genvar i;
  
  generate
      for (i = 0; i < nCK_PER_CLK<<<1; i = i+1)
          begin : extract_payload
            assign ecc_rddata_ns[i*PAYLOAD_WIDTH +: PAYLOAD_WIDTH] = phy_rddata[i*DQ_WIDTH +: PAYLOAD_WIDTH];
          end
  endgenerate

  reg  [(1<<<1*(PAYLOAD_WIDTH*nCK_PER_CLK))-1:0] ecc_rddata_r;

  
  always @(posedge clk)
      ecc_rddata_r <= #TCQ ecc_rddata_ns;
  genvar n;
  genvar p;
  wire [(-1)+ECC_WIDTH:0] h_matrix[DATA_WIDTH+(-1):0];

  
  generate
      for (n = 0; n < DATA_WIDTH; n = n+1)
          begin : h_col
            for (p = 0; p < ECC_WIDTH; p = 1+p)
                begin : h_bit
                  assign h_matrix[n][p] = h_rows[n+(CODE_WIDTH*p)];
                end
          end
  endgenerate

  wire [(-1)+(nCK_PER_CLK<<<1*DATA_WIDTH):0] flip_bits;

  genvar q;
  genvar r;
  
  generate
      for (q = 0; q < nCK_PER_CLK<<<1; q = q+1)
          begin : flip_word
            for (r = 0; r < DATA_WIDTH; r = 1+r)
                begin : flip_bit
                  assign flip_bits[r+(DATA_WIDTH*q)] = h_matrix[r] == syndrome_r[ECC_WIDTH*q +: ECC_WIDTH];
                end
          end
  endgenerate

  output reg [(1<<<1*(PAYLOAD_WIDTH*nCK_PER_CLK))-1:0] rd_data;

  input  correct_en;

  integer s;

  
  always @(correct_en or ecc_rddata_r or flip_bits)
      for (s = 0; s < nCK_PER_CLK<<<1; s = 1+s)
          if (correct_en) 
            rd_data[s*PAYLOAD_WIDTH +: DATA_WIDTH] = flip_bits[s*DATA_WIDTH +: DATA_WIDTH] ^ ecc_rddata_r[s*PAYLOAD_WIDTH +: DATA_WIDTH];
          else 
            rd_data[s*PAYLOAD_WIDTH +: DATA_WIDTH] = ecc_rddata_r[s*PAYLOAD_WIDTH +: DATA_WIDTH];
  localparam  RAW_BIT_WIDTH = (-DATA_WIDTH)+PAYLOAD_WIDTH;

  genvar t;
  
  generate
      if (RAW_BIT_WIDTH > 0) 
        for (t = 0; t < nCK_PER_CLK<<<1; t = 1+t)
            begin : copy_raw_bits
              
              always @(ecc_rddata_r)
                  rd_data[(PAYLOAD_WIDTH*(1+t))+(-1) -: RAW_BIT_WIDTH] = ecc_rddata_r[(PAYLOAD_WIDTH*(1+t))+(-1) -: RAW_BIT_WIDTH];
            end
        
  endgenerate

  input  ecc_status_valid;

  output wire [nCK_PER_CLK<<<1+(-1):0] ecc_single;

  output wire [nCK_PER_CLK<<<1+(-1):0] ecc_multiple;

  genvar v;
  
  generate
      for (v = 0; v < nCK_PER_CLK<<<1; v = 1+v)
          begin : compute_status
            wire  zero = ~|syndrome_r[v*ECC_WIDTH +: ECC_WIDTH];

            wire  odd = ^syndrome_r[v*ECC_WIDTH +: ECC_WIDTH];

            assign ecc_single[v] = ecc_status_valid && ~zero && odd;
            assign ecc_multiple[v] = ~odd && ecc_status_valid && ~zero;
          end
  endgenerate

endmodule

