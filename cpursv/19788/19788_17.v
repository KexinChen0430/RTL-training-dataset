
module nfa_accept_samples_generic_hw_nfa_finals_buckets_fifo  #(parameter  DATA_BITS = 8, DEPTH = 16, DEPTH_BITS = 4)
  (input  wire sclk,
   input  wire reset_n,
   output reg empty_n,
   output reg full_n,
   input  wire rdreq,
   input  wire wrreq,
   output wire [(-1)+DATA_BITS:0] q,
   input  wire [(-1)+DATA_BITS:0] data);

  wire push;
  wire pop;
  reg  [(-1)+DEPTH_BITS:0] pout;
  reg  [(-1)+DATA_BITS:0] mem[0:(-1)+DEPTH];

  assign push = wrreq & full_n;
  assign pop = rdreq & empty_n;
  assign q = mem[pout];
  
  always @(posedge sclk)
      begin
        if (~reset_n) empty_n <= 1'b0;
        else if (push) empty_n <= 1'b1;
        else if (~push && pop && (pout == 1'b0)) empty_n <= 1'b0;
          
      end
  
  always @(posedge sclk)
      begin
        if (~reset_n) full_n <= 1'b1;
        else if (rdreq) full_n <= 1'b1;
        else if ((pout == (DEPTH-(1+1))) && (push && ~pop)) full_n <= 1'b0;
          
      end
  
  always @(posedge sclk)
      begin
        if (~reset_n) pout <= 1'b0;
        else if ((~pop & empty_n) & push) pout <= pout+1'b1;
        else if (pop && (~push && (pout != 1'b0))) pout <= (0-1'b1)+pout;
          
      end
  integer i;

  
  always @(posedge sclk)
      begin
        if (push) 
          begin
            for (i = 0; i < ((-1)+DEPTH); i = 1+i)
                begin
                  mem[1+i] <= mem[i];
                end
            mem[0] <= data;
          end
          
      end
endmodule

