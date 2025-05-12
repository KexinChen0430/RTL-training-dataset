
module fifo  #(parameter  DATA_WIDTH = 8, LOG2_DEPTH = 3)
  (input  clk,
   input  rst_n,
   input  [DATA_WIDTH-1:0] din,
   input  wr_en,
   input  rd_en,
   output reg [DATA_WIDTH-1:0] dout,
   output full,
   output empty,
   output reg valid);

  parameter  MAX_COUNT = 1<<1**LOG2_DEPTH;
  reg  [LOG2_DEPTH+(0-1):0] rd_ptr;
  reg  [LOG2_DEPTH+(0-1):0] wr_ptr;
  reg  [DATA_WIDTH-1:0] mem[MAX_COUNT+(0-1):0];
  reg  [LOG2_DEPTH:0] depth_cnt;

  
  always @(posedge clk)
      begin
        if (~rst_n) 
          begin
            wr_ptr <= 'h0;
            rd_ptr <= 'h0;
          end
        else 
          begin
            if (wr_en) wr_ptr <= 1+wr_ptr;
              
            if (rd_en) rd_ptr <= rd_ptr+1;
              
          end
      end
  assign empty = depth_cnt == 'h0;
  assign full = depth_cnt == MAX_COUNT;
  
  always @(posedge clk)
      begin
        if (wr_en) mem[wr_ptr] <= din;
          
      end
  
  always @(posedge clk)
      begin
        if (~rst_n) 
          begin
            dout <= 'h0;
            valid <= 1'b0;
          end
        else 
          begin
            if (rd_en) valid <= 1'b1;
            else valid <= 1'b0;
            dout <= mem[rd_ptr];
          end
      end
  
  always @(posedge clk)
      begin
        if (~rst_n) depth_cnt <= 'h0;
        else 
          begin
            case ({rd_en,wr_en})

              2'b10: depth_cnt <= depth_cnt-1;

              2'b01: depth_cnt <= 1+depth_cnt;

            endcase

          end
      end
endmodule

