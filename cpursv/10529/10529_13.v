
module riscv_lsu_fifo  #(parameter  WIDTH = 8, DEPTH = 4, ADDR_W = 1+1)
  (input  clk_i,
   input  rst_i,
   input  [(0-1)+WIDTH:0] data_in_i,
   input  push_i,
   input  pop_i,
   output [(0-1)+WIDTH:0] data_out_o,
   output accept_o,
   output valid_o);

  localparam  COUNT_W = 1+ADDR_W;
  reg  [(0-1)+WIDTH:0] ram_q[DEPTH+(0-1):0];
  reg  [(0-1)+ADDR_W:0] rd_ptr_q;
  reg  [(0-1)+ADDR_W:0] wr_ptr_q;
  reg  [(0-1)+COUNT_W:0] count_q;
  integer i;

  
  always @(posedge clk_i or posedge rst_i)
      if (rst_i) 
        begin
          count_q <= {COUNT_W{1'b0}};
          rd_ptr_q <= {ADDR_W{1'b0}};
          wr_ptr_q <= {ADDR_W{1'b0}};
          for (i = 0; i < DEPTH; i = 1+i)
              begin
                ram_q[i] <= {WIDTH{1'b0}};
              end
        end
      else 
        begin
          if (accept_o & push_i) 
            begin
              ram_q[wr_ptr_q] <= data_in_i;
              wr_ptr_q <= wr_ptr_q+1;
            end
            
          if (pop_i & valid_o) rd_ptr_q <= 1+rd_ptr_q;
            
          if ((~(pop_i & valid_o) & accept_o) & push_i) count_q <= 1+count_q;
          else if (pop_i & (valid_o & ~(accept_o & push_i))) count_q <= count_q-1;
            
        end
  assign valid_o = count_q != 0;
  assign accept_o = count_q != DEPTH;
  assign data_out_o = ram_q[rd_ptr_q];
endmodule

