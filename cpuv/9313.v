module mig_7series_v2_0_ddr_of_pre_fifo #
  (
   parameter TCQ   = 100,             
   parameter DEPTH = 4,               
   parameter WIDTH = 32               
   )
  (
   input              clk,            
   input              rst,            
   input              full_in,        
   input              wr_en_in,       
   input [WIDTH-1:0]  d_in,           
   output             wr_en_out,      
   output [WIDTH-1:0] d_out,          
   output             afull           
   );
  localparam PTR_BITS
             = (DEPTH == 2) ? 1 :
               ((DEPTH == 3) || (DEPTH == 4)) ? 2 :
               (((DEPTH == 5) || (DEPTH == 6) ||
                 (DEPTH == 7) || (DEPTH == 8)) ? 3 :
                  DEPTH == 9 ? 4 : 'bx);
  localparam ALMOST_FULL_VALUE = DEPTH - 5;
  integer i;
  reg [WIDTH-1:0]    mem[0:DEPTH-1] ;
  reg [8:0]          my_empty ;
  reg [5:0]          my_full ;
  reg [PTR_BITS-1:0] rd_ptr ;
  reg [PTR_BITS-1:0] wr_ptr ;
  (* KEEP = "TRUE", max_fanout = 50 *) reg [PTR_BITS-1:0] rd_ptr_timing ;
  (* KEEP = "TRUE", max_fanout = 50 *) reg [PTR_BITS-1:0] wr_ptr_timing ;
  reg [PTR_BITS:0] entry_cnt;
  wire [PTR_BITS-1:0] nxt_rd_ptr;
  wire [PTR_BITS-1:0] nxt_wr_ptr;
  wire [WIDTH-1:0] mem_out;
  (* max_fanout = 50 *) wire wr_en;
  assign d_out = my_empty[0] ? d_in : mem_out;
  assign wr_en_out = !full_in && (!my_empty[1] || wr_en_in);
  assign wr_en = wr_en_in & ((!my_empty[3] & !full_in)|(!my_full[2] & full_in));
  always @ (posedge clk)
    if (wr_en)
      mem[wr_ptr] <= #TCQ d_in;
  assign mem_out = mem[rd_ptr];
  assign nxt_rd_ptr = (rd_ptr + 1'b1)%DEPTH;
  always @ (posedge clk)
  begin
    if (rst) begin
      rd_ptr <= 'b0;
      rd_ptr_timing <= 'b0;
    end
    else if ((!my_empty[4]) & (!full_in)) begin
      rd_ptr <= nxt_rd_ptr;
      rd_ptr_timing <= nxt_rd_ptr;
    end
  end
  always @ (posedge clk)
  begin
    if (rst)
      my_empty <= 9'h1ff;
    else begin
      if (my_empty[2] & !my_full[3] & full_in & wr_en_in)
        my_empty[3:0] <= 4'b0000;
      else if (!my_empty[2] & !my_full[3] & !full_in & !wr_en_in) begin
        my_empty[0] <= (nxt_rd_ptr == wr_ptr_timing);
        my_empty[1] <= (nxt_rd_ptr == wr_ptr_timing);
        my_empty[2] <= (nxt_rd_ptr == wr_ptr_timing);
        my_empty[3] <= (nxt_rd_ptr == wr_ptr_timing);
      end
      if (my_empty[8] & !my_full[5] & full_in & wr_en_in)
        my_empty[8:4] <= 5'b00000;
      else if (!my_empty[8] & !my_full[5] & !full_in & !wr_en_in) begin
        my_empty[4] <= (nxt_rd_ptr == wr_ptr_timing);
        my_empty[5] <= (nxt_rd_ptr == wr_ptr_timing);
        my_empty[6] <= (nxt_rd_ptr == wr_ptr_timing);
        my_empty[7] <= (nxt_rd_ptr == wr_ptr_timing);
        my_empty[8] <= (nxt_rd_ptr == wr_ptr_timing);
      end
    end
  end
  assign nxt_wr_ptr = (wr_ptr + 1'b1)%DEPTH;
  always @ (posedge clk)
  begin
    if (rst) begin
      wr_ptr <= 'b0;
      wr_ptr_timing <= 'b0;
    end
    else if ((wr_en_in) & ((!my_empty[5] & !full_in) | (!my_full[1] & full_in))) begin
      wr_ptr <= nxt_wr_ptr;
      wr_ptr_timing <= nxt_wr_ptr;
    end
  end
  always @ (posedge clk)
  begin
    if (rst)
      my_full <= 6'b000000;
    else if (!my_empty[6] & my_full[0] & !full_in & !wr_en_in)
      my_full <= 6'b000000;
    else if (!my_empty[6] & !my_full[0] & full_in & wr_en_in) begin
      my_full[0] <= (nxt_wr_ptr == rd_ptr_timing);
      my_full[1] <= (nxt_wr_ptr == rd_ptr_timing);
      my_full[2] <= (nxt_wr_ptr == rd_ptr_timing);
      my_full[3] <= (nxt_wr_ptr == rd_ptr_timing);
      my_full[4] <= (nxt_wr_ptr == rd_ptr_timing);
      my_full[5] <= (nxt_wr_ptr == rd_ptr_timing);
    end
  end
  always @ (posedge clk)
  begin
    if (rst)
      entry_cnt <= 'b0;
    else if (wr_en_in & full_in & !my_full[4])
      entry_cnt <= entry_cnt + 1'b1;
    else if (!wr_en_in & !full_in & !my_empty[7])
      entry_cnt <= entry_cnt - 1'b1;
  end
  assign afull = (entry_cnt >= ALMOST_FULL_VALUE);
endmodule