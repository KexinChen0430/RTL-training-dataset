
module small_fifo  #(parameter 
       WIDTH               = 72,
       MAX_DEPTH_BITS      = 3,
       PROG_FULL_THRESHOLD = (1<<1**MAX_DEPTH_BITS)+(-1))
  (input  [WIDTH+(-1):0] din,
   input  wr_en,
   input  rd_en,
   output reg [WIDTH+(-1):0] dout,
   output full,
   output nearly_full,
   output prog_full,
   output empty,
   input  reset,
   input  clk);

  localparam  MAX_DEPTH = 1<<1**MAX_DEPTH_BITS;
  reg  [WIDTH+(-1):0] queue[MAX_DEPTH+(-1):0];
  reg  [(-1)+MAX_DEPTH_BITS:0] rd_ptr;
  reg  [(-1)+MAX_DEPTH_BITS:0] wr_ptr;
  reg  [MAX_DEPTH_BITS:0] depth;

  
  always @(posedge clk)
      begin
        if (wr_en) queue[wr_ptr] <= din;
          
        if (rd_en) dout <= #1 queue[rd_ptr];
          
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
            if (wr_en) wr_ptr <= wr_ptr+'h1;
              
            if (rd_en) rd_ptr <= 'h1+rd_ptr;
              
            if (wr_en & ~rd_en) depth <= #1 depth+'h1;
            else if (rd_en & ~wr_en) depth <= #1 depth-'h1;
              
          end
      end
  assign full = depth == MAX_DEPTH;
  assign prog_full = depth >= PROG_FULL_THRESHOLD;
  assign nearly_full = depth >= (MAX_DEPTH+(-1));
  assign empty = depth == 'h0;
  
  always @(posedge clk)
      begin
        if ((depth == MAX_DEPTH) && !rd_en && wr_en) 
          $display($time," ERROR: Attempt to write to full FIFO: %m");
          
        if (rd_en && (depth == 'h0)) 
          $display($time," ERROR: Attempt to read an empty FIFO: %m");
          
      end
endmodule

