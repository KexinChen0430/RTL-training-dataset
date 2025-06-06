
module nfa_accept_samples_generic_hw_nfa_finals_buckets_fifo  #(parameter  DATA_BITS = 8, DEPTH = 16, DEPTH_BITS = 4)
  (input  wire sclk,
   input  wire reset_n,
   output reg empty_n,
   output reg full_n,
   input  wire rdreq,
   input  wire wrreq,
   output wire [DATA_BITS-1:0] q,
   input  wire [DATA_BITS-1:0] data);

  wire push;
  wire pop;
  reg  [(0-1)+DEPTH_BITS:0] pout;
  reg  [DATA_BITS-1:0] mem[0:(0-1)+DEPTH];

  assign push = full_n & wrreq;
  assign pop = rdreq & empty_n;
  assign q = mem[pout];
  
  always @(posedge sclk)
      begin
        if (~reset_n) empty_n <= 1'b0;
        else if (push) empty_n <= 1'b1;
        else if ((pout == 1'b0) && (pop && ~push)) empty_n <= 1'b0;
          
      end
  
  always @(posedge sclk)
      begin
        if (~reset_n) full_n <= 1'b1;
        else if (rdreq) full_n <= 1'b1;
        else if (~pop && push && (pout == (DEPTH-(1+1)))) full_n <= 1'b0;
          
      end
  
  always @(posedge sclk)
      begin
        if (~reset_n) pout <= 1'b0;
        else if (empty_n & (push & ~pop)) pout <= 1'b1+pout;
        else if (pop && (~push && (pout != 1'b0))) pout <= pout-1'b1;
          
      end
  integer i;

  
  always @(posedge sclk)
      begin
        if (push) 
          begin
            for (i = 0; i < ((0-1)+DEPTH); i = i+1)
                begin
                  mem[i+1] <= mem[i];
                end
            mem[0] <= data;
          end
          
      end
endmodule

