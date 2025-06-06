
module dport_axi_fifo  #(parameter  WIDTH = 8, DEPTH = 1<<1, ADDR_W = 1)
  (input  clk_i,
   input  rst_i,
   input  [WIDTH-1:0] data_in_i,
   input  push_i,
   input  pop_i,
   output [WIDTH-1:0] data_out_o,
   output accept_o,
   output valid_o);

  localparam  COUNT_W = ADDR_W+1;
  reg  [WIDTH-1:0] ram_q[(0-1)+DEPTH:0];
  reg  [ADDR_W+(0-1):0] rd_ptr_q;
  reg  [ADDR_W+(0-1):0] wr_ptr_q;
  reg  [COUNT_W-1:0] count_q;

  
  always @(posedge clk_i or posedge rst_i)
      if (rst_i) 
        begin
          count_q <= {COUNT_W{1'b0}};
          rd_ptr_q <= {ADDR_W{1'b0}};
          wr_ptr_q <= {ADDR_W{1'b0}};
        end
      else 
        begin
          if (push_i & accept_o) 
            begin
              ram_q[wr_ptr_q] <= data_in_i;
              wr_ptr_q <= wr_ptr_q+1;
            end
            
          if (valid_o & pop_i) rd_ptr_q <= 1+rd_ptr_q;
            
          if (~(valid_o & pop_i) & (push_i & accept_o)) count_q <= 1+count_q;
          else if ((~(push_i & accept_o) & valid_o) & pop_i) count_q <= count_q-1;
            
        end
  assign valid_o = count_q != 0;
  assign accept_o = count_q != DEPTH;
  assign data_out_o = ram_q[rd_ptr_q];
endmodule

