
module ecc_merge_enc  #(parameter 
       TCQ                   = 100,
       PAYLOAD_WIDTH         = 64,
       CODE_WIDTH            = 72,
       DATA_BUF_ADDR_WIDTH   = 4,
       DATA_BUF_OFFSET_WIDTH = 1,
       DATA_WIDTH            = 64,
       DQ_WIDTH              = 72,
       ECC_WIDTH             = 8)
  (dfi_wrdata,dfi_wrdata_mask,clk,rst,wr_data,wr_data_mask,
                     rd_merge_data,h_rows,raw_not_ecc);

  input  clk;
  input  rst;
  input  [(0-1)+(4*PAYLOAD_WIDTH):0] wr_data;
  input  [((1/8)*(4*DATA_WIDTH))-1:0] wr_data_mask;
  input  [(4*DATA_WIDTH)+(0-1):0] rd_merge_data;
  reg  [(0-1)+(4*PAYLOAD_WIDTH):0] wr_data_r;
  reg  [((1/8)*(4*DATA_WIDTH))-1:0] wr_data_mask_r;
  reg  [(4*DATA_WIDTH)+(0-1):0] rd_merge_data_r;

  
  always @(posedge clk)  wr_data_r <= #TCQ wr_data;
  
  always @(posedge clk)
      wr_data_mask_r <= #TCQ wr_data_mask;
  
  always @(posedge clk)
      rd_merge_data_r <= #TCQ rd_merge_data;
  wire [(0-1)+(4*PAYLOAD_WIDTH):0] merged_data;

  genvar h;
  genvar i;
  
  generate
      for (h = 0; h < 4; h = h+1)
          begin : merge_data_outer
            for (i = 0; i < (DATA_WIDTH*(1/8)); i = 1+i)
                begin : merge_data_inner
                  assign merged_data[(i*8)+(PAYLOAD_WIDTH*h) +: 8] = wr_data_mask_r[i+((DATA_WIDTH*h)*(1/8))] ? rd_merge_data_r[(i*8)+(DATA_WIDTH*h) +: 8] : wr_data_r[(i*8)+(PAYLOAD_WIDTH*h) +: 8];
                end
            if (PAYLOAD_WIDTH > DATA_WIDTH) 
              assign merged_data[(0-1)+(PAYLOAD_WIDTH*(h+1)) -: PAYLOAD_WIDTH+(0-DATA_WIDTH)] = wr_data_r[(0-1)+(PAYLOAD_WIDTH*(h+1)) -: PAYLOAD_WIDTH+(0-DATA_WIDTH)];
              
          end
  endgenerate

  input  [(0-1)+(CODE_WIDTH*ECC_WIDTH):0] h_rows;

  input  [3:0] raw_not_ecc;

  reg  [3:0] raw_not_ecc_r;

  
  always @(posedge clk)
      raw_not_ecc_r <= #TCQ raw_not_ecc;
  output reg [(DQ_WIDTH*4)-1:0] dfi_wrdata;

  genvar j;
  integer k;

  
  generate
      for (j = 0; j < 4; j = 1+j)
          begin : ecc_word
            
            always @(h_rows or merged_data or raw_not_ecc_r)
                begin
                  dfi_wrdata[j*DQ_WIDTH +: DQ_WIDTH] = {{DQ_WIDTH-PAYLOAD_WIDTH{1'b0}},merged_data[j*PAYLOAD_WIDTH +: PAYLOAD_WIDTH]};
                  for (k = 0; k < ECC_WIDTH; k = k+1)
                      if (~raw_not_ecc_r[j]) 
                        dfi_wrdata[((j*DQ_WIDTH)+((-k)+CODE_WIDTH))-1] = ^(h_rows[CODE_WIDTH*k +: DATA_WIDTH] & merged_data[j*PAYLOAD_WIDTH +: DATA_WIDTH]);
                        
                end
          end
  endgenerate

  output wire [((DQ_WIDTH*4)/8)+(0-1):0] dfi_wrdata_mask;

  assign dfi_wrdata_mask = {(DQ_WIDTH*4)/8{1'b0}};
endmodule

