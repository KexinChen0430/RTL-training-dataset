
module fifo_4x32(input  [31:0] din,
                 input  wr_en,
                 input  rd_en,
                 output [31:0] dout,
                 output full,
                 output empty,
                 input  reset,
                 input  clk);

  parameter  MAX_DEPTH_BITS = 2;
  parameter  MAX_DEPTH = 2**MAX_DEPTH_BITS;
  reg  [31:0] queue[(0-1)+MAX_DEPTH:0];
  reg  [MAX_DEPTH_BITS-1:0] rd_ptr;
  reg  [MAX_DEPTH_BITS-1:0] wr_ptr;
  reg  [(0-1)+(MAX_DEPTH_BITS+1):0] depth;

  
  always @(posedge clk)
      begin
        if (wr_en) queue[wr_ptr] <= din;
          
      end
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            rd_ptr <= 'h0;
            wr_ptr <= 'h0;
            depth <= 'h0;
          end
        else 
          begin
            if (wr_en) wr_ptr <= 'h1+wr_ptr;
              
            if (rd_en) rd_ptr <= 'h1+rd_ptr;
              
            if (wr_en & ~rd_en) depth <= depth+'h1;
              
            if (~wr_en & rd_en) depth <= (-'h1)+depth;
              
          end
      end
  assign dout = queue[rd_ptr];
  assign full = depth == MAX_DEPTH;
  assign empty = depth == 'h0;
  
  always @(posedge clk)
      begin
        if ((depth == MAX_DEPTH) && wr_en && !rd_en) 
          $display($time," ERROR: Attempt to write to full FIFO: %m");
          
        if ((depth == 'h0) && rd_en) 
          $display($time," ERROR: Attempt to read an empty FIFO: %m");
          
      end
endmodule

