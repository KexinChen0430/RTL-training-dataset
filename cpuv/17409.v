module ResetToBool( RST, VAL);
   input  RST;
   output VAL;
   assign VAL = (RST == `BSV_RESET_VALUE);
endmodule 