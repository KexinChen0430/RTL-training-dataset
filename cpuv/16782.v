module ResetEither(A_RST,
                   B_RST,
                   RST_OUT
                  ) ;
   input            A_RST;
   input            B_RST;
   output           RST_OUT;
   assign RST_OUT = ((A_RST == `BSV_RESET_VALUE) || (B_RST == `BSV_RESET_VALUE)) ? `BSV_RESET_VALUE : ~ `BSV_RESET_VALUE;
endmodule