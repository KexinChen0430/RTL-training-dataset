
module USR_ACCESSE2(CFGCLK,DATA,DATAVALID);

  output CFGCLK;
  output DATAVALID;
  output [31:0] DATA;

  
  specify
    specparam  PATHPULSE$ = 0;

  endspecify

endmodule

