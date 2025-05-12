module USR_ACCESSE2 ( 
  CFGCLK, 
  DATA, 
  DATAVALID 
);
  `ifdef XIL_TIMING 
    parameter LOC = "UNPLACED"; 
  `endif 
  output CFGCLK; 
  output DATAVALID; 
  output [31:0] DATA; 
  specify 
    specparam PATHPULSE$ = 0; 
  endspecify 
endmodule 