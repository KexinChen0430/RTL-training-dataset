
module rw_manager_ram_csr  #(parameter  DATA_WIDTH = 32, ADDR_WIDTH = 2, NUM_WORDS = 4)
  (input  csr_clk,
   input  csr_ena,
   input  csr_din,
   input  ram_clk,
   input  wren,
   input  [(0-1)+DATA_WIDTH:0] data,
   input  [ADDR_WIDTH-1:0] wraddress,
   input  [ADDR_WIDTH-1:0] rdaddress,
   output reg [(0-1)+DATA_WIDTH:0] q,
   output reg csr_dout);

  localparam integer  DATA_COUNT = NUM_WORDS*DATA_WIDTH;
  reg  [DATA_COUNT-1:0] all_data;
  wire [DATA_COUNT-1:0] load_data;
  wire [(0-1)+DATA_WIDTH:0] row_data[(0-1)+NUM_WORDS:0];
  wire int_clk;

  assign int_clk = ~csr_ena ? csr_clk : ram_clk;
  
  always @(posedge int_clk)
      begin
        if (~csr_ena) all_data <= {all_data[DATA_COUNT-2:0],csr_din};
        else if (wren) all_data <= load_data;
        else all_data <= all_data;
        q <= row_data[rdaddress];
      end
  
  always @(negedge csr_clk)
      begin
        csr_dout <= all_data[DATA_COUNT-1];
      end
  
  generate
      genvar i;
      for (i = 0; i < NUM_WORDS; i = i+1)
          begin : row_assign
            assign row_data[i] = all_data[(DATA_WIDTH*(i+1))-1:DATA_WIDTH*i];
          end
  endgenerate

  
  generate
      genvar j,k;
      for (j = 0; j < NUM_WORDS; j = 1+j)
          begin : row
            for (k = 0; k < DATA_WIDTH; k = 1+k)
                begin : column
                  assign load_data[(DATA_WIDTH*j)+k] = (wraddress == j) ? data[k] : all_data[(DATA_WIDTH*j)+k];
                end
          end
  endgenerate

endmodule

