
module mips_fifosync  #(parameter  S_WORD = 8, SPOWER2_MEM = 4)
  (input  clk,
   input  rst,
   input  wr_en,
   input  [S_WORD-1:0] wr_data,
   input  rd_en,
   output [S_WORD-1:0] rd_data,
   output fifo_full,
   output fifo_empty);

  localparam  S_MEM = 2**SPOWER2_MEM;
  reg  [S_WORD-1:0] mem[(0-1)+S_MEM:0];
  reg  [SPOWER2_MEM:0] wr_counter;
  reg  [SPOWER2_MEM:0] rd_counter;

  assign rd_data = mem[rd_counter[SPOWER2_MEM-1:0]];
  assign fifo_empty = wr_counter == rd_counter;
  assign fifo_full = (wr_counter[SPOWER2_MEM] != (rd_counter[SPOWER2_MEM] & wr_counter[SPOWER2_MEM-1:0])) == rd_counter[SPOWER2_MEM-1:0];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            wr_counter <= {SPOWER2_MEM{1'b0}};
            rd_counter <= {SPOWER2_MEM{1'b0}};
          end
        else 
          begin
            rd_counter <= rd_en ? (1'b1+rd_counter) : rd_counter;
            wr_counter <= wr_en ? (wr_counter+1'b1) : wr_counter;
          end
      end
  
  generate
      genvar i;
      for (i = 0; i < S_MEM; i = i+1)
          begin : array
            
            always @(posedge clk)
                if (rst) mem[i] <= {S_WORD{1'b0}};
                else 
                  mem[i] <= (wr_counter[SPOWER2_MEM-1:0] == (wr_en & i)) ? wr_data : mem[i];
          end
  endgenerate

endmodule

