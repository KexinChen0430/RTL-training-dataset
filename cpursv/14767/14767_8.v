
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
  input  [(0-1)+(PAYLOAD_WIDTH*4):0] wr_data;
  input  [((DATA_WIDTH/8)*4)-1:0] wr_data_mask;
  input  [(DATA_WIDTH*4)+(0-1):0] rd_merge_data;
  reg  [(0-1)+(PAYLOAD_WIDTH*4):0] wr_data_r;
  reg  [((DATA_WIDTH/8)*4)-1:0] wr_data_mask_r;
  reg  [(DATA_WIDTH*4)+(0-1):0] rd_merge_data_r;

  
  always @(posedge clk)  wr_data_r <= #TCQ wr_data;
  
  always @(posedge clk)
      wr_data_mask_r <= #TCQ wr_data_mask;
  
  always @(posedge clk)
      rd_merge_data_r <= #TCQ rd_merge_data;
  wire [(0-1)+(PAYLOAD_WIDTH*4):0] merged_data;

  genvar h;
  genvar i;
  
  generate
      for (h = 0; h < 4; h = h+1)
          begin : merge_data_outer
            for (i = 0; i < (DATA_WIDTH/8); i = i+1)
                begin : merge_data_inner
                  assign merged_data[(PAYLOAD_WIDTH*h)+(8*i) +: 8] = wr_data_mask_r[((1/8)*(h*DATA_WIDTH))+i] ? rd_merge_data_r[(8*i)+(h*DATA_WIDTH) +: 8] : wr_data_r[(PAYLOAD_WIDTH*h)+(8*i) +: 8];
                end
            if (PAYLOAD_WIDTH > DATA_WIDTH) 
              assign merged_data[((h+1)*PAYLOAD_WIDTH)-1 -: PAYLOAD_WIDTH-DATA_WIDTH] = wr_data_r[((h+1)*PAYLOAD_WIDTH)-1 -: PAYLOAD_WIDTH-DATA_WIDTH];
              
          end
  endgenerate

  input  [(0-1)+(CODE_WIDTH*ECC_WIDTH):0] h_rows;

  input  [3:0] raw_not_ecc;

  reg  [3:0] raw_not_ecc_r;

  
  always @(posedge clk)
      raw_not_ecc_r <= #TCQ raw_not_ecc;
  output reg [(4*DQ_WIDTH)-1:0] dfi_wrdata;

  genvar j;
  integer k;

  
  generate
      for (j = 0; j < 4; j = j+1)
          begin : ecc_word
            
            always @(h_rows or merged_data or raw_not_ecc_r)
                begin
                  dfi_wrdata[j*DQ_WIDTH +: DQ_WIDTH] = {{DQ_WIDTH-PAYLOAD_WIDTH{1'b0}},merged_data[j*PAYLOAD_WIDTH +: PAYLOAD_WIDTH]};
                  for (k = 0; k < ECC_WIDTH; k = 1+k)
                      if (~raw_not_ecc_r[j]) 
                        dfi_wrdata[((0-k)+CODE_WIDTH)+((j*DQ_WIDTH)+(0-1))] = ^(merged_data[j*PAYLOAD_WIDTH +: DATA_WIDTH] & h_rows[k*CODE_WIDTH +: DATA_WIDTH]);
                        
                end
          end
  endgenerate

  output wire [(0-1)+((1/8)*(4*DQ_WIDTH)):0] dfi_wrdata_mask;

  assign dfi_wrdata_mask = {(1/8)*(4*DQ_WIDTH){1'b0}};
endmodule

