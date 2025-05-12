
module wptr_full  #(parameter  ADDRSIZE = 4)
  (input  wire wclk,
   input  wire wrst_n,
   input  wire winc,
   input  wire [ADDRSIZE:0] wq2_rptr,
   output reg wfull,
   output reg awfull,
   output wire [(-1)+ADDRSIZE:0] waddr,
   output reg [ADDRSIZE:0] wptr);

  reg  [ADDRSIZE:0] wbin;
  wire [ADDRSIZE:0] wgraynext,wbinnext,wgraynextp1;
  wire awfull_val,wfull_val;

  
  always @(posedge wclk or negedge wrst_n)
      begin
        if (!wrst_n) {wbin,wptr} <= 0;
        else {wbin,wptr} <= {wbinnext,wgraynext};
      end
  assign waddr = wbin[(-1)+ADDRSIZE:0];
  assign wbinnext = wbin+(~wfull & winc);
  assign wgraynext = (~wbinnext & (wbinnext>>1 & (~wbinnext | wbinnext))) | (~(wbinnext>>1 & (~wbinnext | wbinnext)) & wbinnext);
  assign wgraynextp1 = ((~(1'b1+wbinnext) | ~(1'b1+wbinnext)>>1) & (((((1'b1+wbinnext) | (1'b1+wbinnext)>>1) & ((((1'b1+wbinnext) | (1'b1+wbinnext)>>1) | ~(1'b1+wbinnext)) & ~(1'b1+wbinnext)>>1)) | (((1'b1+wbinnext) | (1'b1+wbinnext)>>1) | ~(1'b1+wbinnext)>>1)) & ((1'b1+wbinnext)>>1 & (((1'b1+wbinnext) | (1'b1+wbinnext)>>1) | ~(1'b1+wbinnext))))) ^ ((((((1'b1+wbinnext) | (1'b1+wbinnext)>>1) & ((((1'b1+wbinnext) | (1'b1+wbinnext)>>1) | ~(1'b1+wbinnext)) & ~(1'b1+wbinnext)>>1)) | (((1'b1+wbinnext) | (1'b1+wbinnext)>>1) | ~(1'b1+wbinnext)>>1)) & (1'b1+wbinnext)) & (~(1'b1+wbinnext) | ~(1'b1+wbinnext)>>1));
  assign wfull_val = wgraynext == {~wq2_rptr[ADDRSIZE:(-1)+ADDRSIZE],wq2_rptr[(0-1<<<1)+ADDRSIZE:0]};
  assign awfull_val = wgraynextp1 == {~wq2_rptr[ADDRSIZE:(-1)+ADDRSIZE],wq2_rptr[(0-1<<<1)+ADDRSIZE:0]};
  
  always @(posedge wclk or negedge wrst_n)
      begin
        if (!wrst_n) 
          begin
            awfull <= 1'b0;
            wfull <= 1'b0;
          end
        else 
          begin
            awfull <= awfull_val;
            wfull <= wfull_val;
          end
      end
endmodule

