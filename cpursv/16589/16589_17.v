
module ecc_dec_fix  #(parameter 
       TCQ           = 100,
       PAYLOAD_WIDTH = 64,
       CODE_WIDTH    = 72,
       DATA_WIDTH    = 64,
       DQ_WIDTH      = 72,
       ECC_WIDTH     = 8)
  (rd_data,ecc_single,ecc_multiple,clk,rst,h_rows,dfi_rddata,
                   correct_en,ecc_status_valid);

  input  clk;
  input  rst;
  input  [(ECC_WIDTH*CODE_WIDTH)+(0-1):0] h_rows;
  input  [(0-1)+(4*DQ_WIDTH):0] dfi_rddata;
  wire [(ECC_WIDTH*4)+(0-1):0] syndrome_ns;

  genvar k;
  genvar m;
  
  generate
      for (k = 0; k < 4; k = k+1)
          begin : ecc_word
            for (m = 0; m < ECC_WIDTH; m = 1+m)
                begin : ecc_bit
                  assign syndrome_ns[m+(ECC_WIDTH*k)] = ^(dfi_rddata[DQ_WIDTH*k +: CODE_WIDTH] & h_rows[CODE_WIDTH*m +: CODE_WIDTH]);
                end
          end
  endgenerate

  reg  [(ECC_WIDTH*4)+(0-1):0] syndrome_r;

  
  always @(posedge clk)
      syndrome_r <= #TCQ syndrome_ns;
  wire [(4*PAYLOAD_WIDTH)+(0-1):0] ecc_rddata_ns;

  genvar i;
  
  generate
      for (i = 0; i < 4; i = i+1)
          begin : extract_payload
            assign ecc_rddata_ns[i*PAYLOAD_WIDTH +: PAYLOAD_WIDTH] = dfi_rddata[DQ_WIDTH*i +: PAYLOAD_WIDTH];
          end
  endgenerate

  reg  [(4*PAYLOAD_WIDTH)+(0-1):0] ecc_rddata_r;

  
  always @(posedge clk)
      ecc_rddata_r <= #TCQ ecc_rddata_ns;
  genvar n;
  genvar p;
  wire [ECC_WIDTH-1:0] h_matrix[DATA_WIDTH+(0-1):0];

  
  generate
      for (n = 0; n < DATA_WIDTH; n = 1+n)
          begin : h_col
            for (p = 0; p < ECC_WIDTH; p = p+1)
                begin : h_bit
                  assign h_matrix[n][p] = h_rows[(p*CODE_WIDTH)+n];
                end
          end
  endgenerate

  wire [(DATA_WIDTH*4)-1:0] flip_bits;

  genvar q;
  genvar r;
  
  generate
      for (q = 0; q < 4; q = 1+q)
          begin : flip_word
            for (r = 0; r < DATA_WIDTH; r = r+1)
                begin : flip_bit
                  assign flip_bits[r+(DATA_WIDTH*q)] = h_matrix[r] == syndrome_r[ECC_WIDTH*q +: ECC_WIDTH];
                end
          end
  endgenerate

  output reg [(4*PAYLOAD_WIDTH)+(0-1):0] rd_data;

  input  correct_en;

  integer s;

  
  always @(correct_en or ecc_rddata_r or flip_bits)
      for (s = 0; s < 4; s = 1+s)
          if (correct_en) 
            rd_data[s*PAYLOAD_WIDTH +: DATA_WIDTH] = (ecc_rddata_r[s*PAYLOAD_WIDTH +: DATA_WIDTH] & (~flip_bits[s*DATA_WIDTH +: DATA_WIDTH] & (ecc_rddata_r[s*PAYLOAD_WIDTH +: DATA_WIDTH] | flip_bits[s*DATA_WIDTH +: DATA_WIDTH]))) | ((~ecc_rddata_r[s*PAYLOAD_WIDTH +: DATA_WIDTH] & (~flip_bits[s*DATA_WIDTH +: DATA_WIDTH] & (ecc_rddata_r[s*PAYLOAD_WIDTH +: DATA_WIDTH] | flip_bits[s*DATA_WIDTH +: DATA_WIDTH]))) | (~ecc_rddata_r[s*PAYLOAD_WIDTH +: DATA_WIDTH] & flip_bits[s*DATA_WIDTH +: DATA_WIDTH]));
          else 
            rd_data[s*PAYLOAD_WIDTH +: DATA_WIDTH] = ecc_rddata_r[s*PAYLOAD_WIDTH +: DATA_WIDTH];
  localparam  RAW_BIT_WIDTH = (0-DATA_WIDTH)+PAYLOAD_WIDTH;

  genvar t;
  
  generate
      if (RAW_BIT_WIDTH > 0) 
        for (t = 0; t < 4; t = t+1)
            begin : copy_raw_bits
              
              always @(ecc_rddata_r)
                  rd_data[(0-1)+((t+1)*PAYLOAD_WIDTH) -: RAW_BIT_WIDTH] = ecc_rddata_r[(0-1)+((t+1)*PAYLOAD_WIDTH) -: RAW_BIT_WIDTH];
            end
        
  endgenerate

  input  ecc_status_valid;

  output wire [3:0] ecc_single;

  output wire [3:0] ecc_multiple;

  genvar v;
  
  generate
      for (v = 0; v < 4; v = v+1)
          begin : compute_status
            wire  zero = ~|syndrome_r[ECC_WIDTH*v +: ECC_WIDTH];

            wire  odd = ^syndrome_r[ECC_WIDTH*v +: ECC_WIDTH];

            assign ecc_single[v] = ~zero && ecc_status_valid && odd;
            assign ecc_multiple[v] = ~zero && ~odd && ecc_status_valid;
          end
  endgenerate

endmodule

