module cellram_pathdelay (
    clk,            
    adv_n,          
    zz_n,           
    ce_n,           
    oe_n,           
    we_n,           
    by_n,           
    addr,           
    clk2waite,      
    adv2dqe,        
    adv2dq,         
    adv2wi,         
    zz2pd,          
    ce2dqe,         
    ce2dq,          
    ce2cem,         
    ce2wi,          
    ce2waite,       
    ce2wait,        
    ce2rst,         
    oe2dqe,         
    oe2dq,          
    soe2dq,         
    oe2waite,       
    oe2wait,        
    we2dqe,         
    we2waite,       
    we2dq,          
    by2dqe,         
    by2dq,          
    addr2dq,        
    addr2wi,        
    saddr2dq        
);
`include "cellram_parameters.vh"
input clk;
input adv_n;
input zz_n;
input ce_n;
input oe_n;
input we_n;
input [BY_BITS-1:0] by_n; 
input [ADDR_BITS-1:0] addr; 
output clk2waite;
output adv2dqe;
output adv2dq;
output adv2wi;
output zz2pd;
output ce2dqe;
output ce2dq;
output ce2cem;
output ce2wi;
output ce2waite;
output ce2wait;
output ce2rst;
output oe2dqe;
output oe2dq;
output soe2dq;
output oe2waite;
output oe2wait;
output we2dqe;
output we2waite;
output we2dq;
output by2dqe;
output by2dq;
output addr2dq;
output addr2wi;
output saddr2dq;
reg adv2dqr, addr2dqr, addr2wir, saddr2dqr, clk2waiter;
always @(negedge adv_n) begin
    if (!adv_n) begin 
        adv2dqr <= 1'b0; 
        adv2dqr <= #(1) 1'b1; 
    end
end
always @(addr[ADDR_BITS-1:4]) begin
    addr2dqr <= 1'b0; 
    addr2dqr <= #(1) 1'b1; 
end
always @(addr) begin
    addr2wir <= 1'b0; 
    addr2wir <= #(1) 1'b1; 
end
always @(posedge clk) begin
    if (!adv_n) begin 
        saddr2dqr <= 1'b0; 
        saddr2dqr <= #(1) 1'b1; 
    end
end
always @(posedge ce_n or posedge clk) begin
    clk2waiter <= !ce_n; 
end
assign clk2waite = clk2waiter;
assign adv2dqe   = adv_n;
assign adv2dq    = adv2dqr;
assign adv2wi    = adv2dqr;
assign zz2pd     = !zz_n;
assign ce2dqe    = !ce_n;
assign ce2dq     = !ce_n;
assign ce2cem    = !ce_n;
assign ce2wi     = !ce_n;
assign ce2waite  = !ce_n;
assign ce2wait   = !ce_n;
assign ce2rst    = ce_n;
assign oe2dqe    = !oe_n;
assign oe2dq     = !oe_n;
assign soe2dq    = !oe_n;
assign oe2waite  = !oe_n;
assign oe2wait   = !oe_n;
assign we2dqe    = we_n;
assign we2dq     = we_n;
assign we2waite  = we_n;
assign by2dqe    = !(&by_n); 
assign by2dq     = !(&by_n); 
assign addr2dq   = addr2dqr; 
assign addr2wi   = addr2wir; 
assign saddr2dq  = saddr2dqr; 
specify
    specparam PATHPULSE$ = 0; 
    (clk   =>clk2waite) = (   tKHTL,  tHZ);
    (adv_n =>  adv2dqe) = (    tALZ, tAHZ);
    (negedge adv_n => (adv2dq +: adv_n)) = (tAADV,  tOH);
    (negedge adv_n => (adv2wi +: adv_n)) = (tWI,  0);
    (zz_n  =>    zz2pd) = (    tDPD,    0);
    (ce_n  =>   ce2dqe) = (     tLZ,  tHZ);
    (ce_n  =>    ce2dq) = (     tCO,    0);
    (ce_n  =>   ce2cem) = (    tCEM,    0);
    (ce_n  =>    ce2wi) = (     tWI,    0);
    (ce_n  => ce2waite) = (tCEW_MIN,  tHZ);
    (ce_n  =>  ce2wait) = (tCEW_MAX,    0);
    (ce_n  =>   ce2rst) = (      15,    0);
    (oe_n  =>   oe2dqe) = (    tOLZ, tOHZ);
    (oe_n  =>    oe2dq) = (     tOE,    0);
    (oe_n  =>   soe2dq) = (    tBOE,    0);
    (oe_n  => oe2waite) = (tOEW_MIN,  tHZ);
    (oe_n  =>  oe2wait) = (tOEW_MAX,    0);
    (we_n  =>   we2dqe) = (       0, tWHZ);
    (we_n  =>    we2dq) = (       0,    0);
    (we_n  => we2waite) = (       0,    0);
    (by_n  *>   by2dqe) = (    tBLZ, tBHZ);
    (by_n  *>    by2dq) = (     tBA,    0);
    (addr  *>  addr2dq) = (     tAA,  tOH);
    (addr  *>  addr2wi) = (     tWI,    0);
    (posedge clk   => (saddr2dq +: clk)) = (tABA,  tKOH);
endspecify
endmodule 