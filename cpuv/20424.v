module mux3
  (input  wire            clk, 
   input  wire   `REQ    portA_req, 
   output wire   `RES    portA_res, 
   input  wire   `REQ    portB_req, 
   output wire   `RES    portB_res, 
   input  wire   `REQ    portC_req, 
   output wire   `RES    portC_res, 
   output wire   `REQ    req, 
   input  wire   `RES    res); 
   parameter y = 1;
   parameter m = 32;
   parameter n = 32;
   wire portA_strobe = portA_req`R | portA_req`W;
   wire portB_strobe = portB_req`R | portB_req`W;
   wire portC_strobe = portC_req`R | portC_req`W;
   reg hold_ = 0, selA_ = 0, selB_ = 0, selC_ = 0; 
   wire selA = hold_ ? selA_ : portA_strobe; 
   wire selB = hold_ ? selB_ : ~selA & portB_strobe; 
   wire selC = hold_ ? selC_ : ~selA & ~selB & portC_strobe; 
   always @(posedge clk) hold_ <= res`HOLD;
   always @(posedge clk) selA_ <= selA;
   always @(posedge clk) selB_ <= selB;
   always @(posedge clk) selC_ <= selC;
   assign req = selA ? portA_req :
                selB ? portB_req :
                 portC_req ;
   assign portA_res`RD   = selA_ ? res`RD : 0; 
   assign portB_res`RD   = selB_ ? res`RD : 0; 
   assign portC_res`RD   = selC_ ? res`RD : 0; 
   assign portA_res`HOLD = portA_strobe & (~selA | res`HOLD); 
   assign portB_res`HOLD = portB_strobe & (~selB | res`HOLD); 
   assign portC_res`HOLD = portC_strobe & (~selC | res`HOLD); 
endmodule