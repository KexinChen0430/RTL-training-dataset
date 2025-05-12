
module rw_manager_bitcheck(ck,reset_n,clear,enable,read_data,reference_data,mask,
                           error_word);

  parameter  DATA_WIDTH = "";
  parameter  AFI_RATIO = "";
  localparam  NUMBER_OF_WORDS = AFI_RATIO<<1;
  localparam  DATA_BUS_SIZE = NUMBER_OF_WORDS*DATA_WIDTH;
  input  ck;
  input  reset_n;
  input  clear;
  input  enable;
  input  [DATA_BUS_SIZE-1:0] read_data;
  input  [DATA_BUS_SIZE-1:0] reference_data;
  input  [NUMBER_OF_WORDS-1:0] mask;
  output [(0-1)+DATA_WIDTH:0] error_word;
  reg  [DATA_BUS_SIZE-1:0] read_data_r;
  reg  [(0-1)+DATA_WIDTH:0] error_word;
  reg  enable_r;
  wire [(0-1)+DATA_WIDTH:0] error_compute;

  
  always @(posedge ck or negedge reset_n)
      begin
        if (~reset_n) 
          begin
            error_word <= {DATA_WIDTH{1'b0}};
            read_data_r <= {DATA_BUS_SIZE{1'b0}};
            enable_r <= 1'b0;
          end
        else 
          begin
            if (clear) 
              begin
                error_word <= {DATA_WIDTH{1'b0}};
              end
            else if (enable_r) 
              begin
                error_word <= error_word | error_compute;
              end
              
            read_data_r <= read_data;
            enable_r <= enable;
          end
      end
  genvar b;
  
  generate
      for (b = 0; b < DATA_WIDTH; b = 1+b)
          begin : bit_loop
            if (AFI_RATIO == 2) 
              begin
                assign error_compute[b] = ((((read_data_r[(b+0)+DATA_WIDTH] & ~mask[1]) ^ (~mask[1] & reference_data[(b+0)+DATA_WIDTH])) | (((~mask[2] & (~reference_data[b+DATA_WIDTH<<1] | (reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]))) & ((reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]) | read_data_r[b+DATA_WIDTH<<1])) | ~mask[0])) & (((read_data_r[(b+0)+DATA_WIDTH] & ~mask[1]) ^ (~mask[1] & reference_data[(b+0)+DATA_WIDTH])) | ((((~mask[2] & (~reference_data[b+DATA_WIDTH<<1] | (reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]))) & ((reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]) | read_data_r[b+DATA_WIDTH<<1])) | (~reference_data[b] | ~read_data_r[b])) & (((~mask[2] & (~reference_data[b+DATA_WIDTH<<1] | (reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]))) & ((reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]) | read_data_r[b+DATA_WIDTH<<1])) | ((reference_data[b] & ~read_data_r[b]) | read_data_r[b]))))) | ((~mask[3] & ((((read_data_r[(b+0)+DATA_WIDTH] & ~mask[1]) ^ (~mask[1] & reference_data[(b+0)+DATA_WIDTH])) | (((~mask[2] & (~reference_data[b+DATA_WIDTH<<1] | (reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]))) & ((reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]) | read_data_r[b+DATA_WIDTH<<1])) | ~mask[0])) & (((read_data_r[(b+0)+DATA_WIDTH] & ~mask[1]) ^ (~mask[1] & reference_data[(b+0)+DATA_WIDTH])) | ((((~mask[2] & (~reference_data[b+DATA_WIDTH<<1] | (reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]))) & ((reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]) | read_data_r[b+DATA_WIDTH<<1])) | (~reference_data[b] | ~read_data_r[b])) & (((~mask[2] & (~reference_data[b+DATA_WIDTH<<1] | (reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]))) & ((reference_data[b+DATA_WIDTH<<1] & ~read_data_r[b+DATA_WIDTH<<1]) | read_data_r[b+DATA_WIDTH<<1])) | ((reference_data[b] & ~read_data_r[b]) | read_data_r[b])))))) | (((((~read_data_r[(DATA_WIDTH*3)+b] | ~reference_data[(DATA_WIDTH*3)+b]) & ~reference_data[(DATA_WIDTH*3)+b]) & read_data_r[(DATA_WIDTH*3)+b]) | reference_data[(DATA_WIDTH*3)+b]) & ((~read_data_r[(DATA_WIDTH*3)+b] | ~reference_data[(DATA_WIDTH*3)+b]) & ~mask[3])));
              end
            else 
              begin
                assign error_compute[b] = (~mask[1] & (reference_data[(b+0)+DATA_WIDTH] & ~(read_data_r[(b+0)+DATA_WIDTH] & ~mask[1]))) | (((((~mask[0] & ~reference_data[b]) & read_data_r[b]) | (~mask[0] & (reference_data[b] & ~read_data_r[b]))) | ~(~mask[1] & reference_data[(b+0)+DATA_WIDTH])) & ((((~mask[0] & ~reference_data[b]) & read_data_r[b]) | (~mask[0] & (reference_data[b] & ~read_data_r[b]))) | (read_data_r[(b+0)+DATA_WIDTH] & ~mask[1])));
              end
          end
  endgenerate

endmodule

