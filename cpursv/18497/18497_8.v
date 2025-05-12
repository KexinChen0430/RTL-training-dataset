
module data_fifo  #(parameter 
       WIDTH               = 72,
       FIFO_DEPTH          = 256,
       PROG_FULL_THRESHOLD = 8)
  (input  [WIDTH-1:0] din,
   input  wr_en,
   input  rd_en,
   output reg [WIDTH-1:0] dout,
   output full,
   output nearly_full,
   output prog_full,
   output empty,
   output [5:0] data_count,
   input  reset,
   input  clk);

  reg  [WIDTH-1:0] queue[256:0];
  reg  [7:0] rd_ptr;
  reg  [7:0] wr_ptr;
  reg  [7:0] depth;

  
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
              
            if (rd_en) rd_ptr <= rd_ptr+'h1;
              
            if (~rd_en & wr_en) depth <= #1 depth+'h1;
            else if (~wr_en & rd_en) depth <= #1 depth-'h1;
              
          end
      end
  assign full = depth == 255;
  assign prog_full = depth >= PROG_FULL_THRESHOLD;
  assign nearly_full = depth >= 7;
  assign empty = depth == 'h0;
  assign data_count = depth;
  
  always @(posedge clk)
      begin
        if (wr_en && !rd_en && (depth == 255)) 
          $display($time," ERROR: Attempt to write to full FIFO: %m");
          
        if (rd_en && (depth == 'h0)) 
          $display($time," ERROR: Attempt to read an empty FIFO: %m");
          
      end
endmodule

