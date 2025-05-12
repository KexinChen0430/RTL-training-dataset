
module rptr_empty  #(parameter  ADDRSIZE = 3, ALMOST_EMPTY_SIZE = 3)
  (output reg rempty,
   output reg r_almost_empty,
   output [ADDRSIZE-1:0] raddr,
   output reg [ADDRSIZE:0] rptr,
   input  [ADDRSIZE:0] rq2_wptr,
   input  rinc,
   input  rclk,
   input  rrst_n);

  reg  [ADDRSIZE:0] rbin;
  wire [ADDRSIZE:0] rgraynext,rbinnext;
  reg  [ADDRSIZE:0] rq2_wptr_bin;
  integer i;

  
  always @(posedge rclk or negedge rrst_n)
      if (!rrst_n) {rbin,rptr} <= 0;
      else {rbin,rptr} <= {rbinnext,rgraynext};
  assign raddr = rbin[ADDRSIZE-1:0];
  assign rbinnext = (rinc & ~rempty)+rbin;
  assign rgraynext = rbinnext ^ (rbinnext>>1 & (rbinnext | ~rbinnext));
  wire  rempty_val = rgraynext == rq2_wptr;

  
  always @(rq2_wptr)
      for (i = 0; i < (1+ADDRSIZE); i = i+1)
          rq2_wptr_bin[i] = ^rq2_wptr>>i;
  wire [ADDRSIZE:0] 
       subtract = (rbinnext+(0-rq2_wptr_bin))+ALMOST_EMPTY_SIZE;

  wire  r_almost_empty_val = ~subtract[ADDRSIZE];

  
  always @(posedge rclk or negedge rrst_n)
      if (!rrst_n) 
        begin
          rempty <= 1'b1;
          r_almost_empty <= 1'b1;
        end
      else 
        begin
          rempty <= rempty_val;
          r_almost_empty <= r_almost_empty_val;
        end
endmodule

