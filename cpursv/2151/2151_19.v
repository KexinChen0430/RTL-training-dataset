
module SLEEP_CONTROLv4(output reg MBC_ISOLATE,
                       output MBC_ISOLATE_B,
                       output reg MBC_RESET,
                       output MBC_RESET_B,
                       output MBC_SLEEP,
                       output MBC_SLEEP_B,
                       output SYSTEM_ACTIVE,
                       output WAKEUP_REQ_ORED,
                       input  CLK,
                       input  MBUS_DIN,
                       input  RESETn,
                       input  SLEEP_REQ,
                       input  WAKEUP_REQ0,
                       input  WAKEUP_REQ1,
                       input  WAKEUP_REQ2);

  reg  set_tran_to_wake;
  reg  rst_tran_to_wake;

  assign MBC_ISOLATE_B = ~MBC_ISOLATE;
  assign MBC_RESET_B = ~MBC_RESET;
  reg  MBC_SLEEP_int;

  assign MBC_SLEEP_B = ~MBC_SLEEP;
  reg  tran_to_wake;

  assign SYSTEM_ACTIVE = MBC_SLEEP_B | MBC_ISOLATE_B;
  assign WAKEUP_REQ_ORED = WAKEUP_REQ1 | (WAKEUP_REQ0 | WAKEUP_REQ2);
  
  always @* 
      begin
        if ((WAKEUP_REQ_ORED | (~MBUS_DIN & (WAKEUP_REQ_ORED | MBC_SLEEP_int))) & ((((((~MBUS_DIN & ((((WAKEUP_REQ_ORED | MBC_SLEEP_int) & RESETn) | (WAKEUP_REQ_ORED | MBC_SLEEP_int)) | RESETn)) & (WAKEUP_REQ_ORED | RESETn)) & (((~MBUS_DIN & (WAKEUP_REQ_ORED | MBC_SLEEP_int)) & MBC_SLEEP_int) | RESETn)) & RESETn) | (RESETn & (MBC_SLEEP_int & WAKEUP_REQ_ORED))) | ((((WAKEUP_REQ_ORED | MBC_SLEEP_int) & RESETn) & ((~SLEEP_REQ | (~MBUS_DIN & WAKEUP_REQ_ORED)) | (WAKEUP_REQ_ORED | ~RESETn))) & WAKEUP_REQ_ORED))) set_tran_to_wake = 1'b1;
        else set_tran_to_wake = 1'b0;
      end
  
  always @* 
      begin
        if (((~SLEEP_REQ | (~MBUS_DIN & WAKEUP_REQ_ORED)) | (WAKEUP_REQ_ORED | ~RESETn)) | ((((~SLEEP_REQ | (~MBUS_DIN & WAKEUP_REQ_ORED)) | (WAKEUP_REQ_ORED | ~RESETn)) | ((~SLEEP_REQ | (~MBUS_DIN & WAKEUP_REQ_ORED)) | ~MBUS_DIN)) & MBC_SLEEP_int)) rst_tran_to_wake <= 1'b1;
        else rst_tran_to_wake <= 1'b0;
      end
  wire 
       tran_to_wake_r = RESETn & ((WAKEUP_REQ_ORED | RESETn) & rst_tran_to_wake);

  
  always @(negedge tran_to_wake_r or posedge set_tran_to_wake)
      begin
        if (~tran_to_wake_r) tran_to_wake <= 1'b0;
        else tran_to_wake <= 1'b1;
      end
  
  always @(negedge RESETn or posedge CLK)
      begin
        if (~RESETn) MBC_ISOLATE <= 1'b1;
        else MBC_ISOLATE <= ~tran_to_wake | MBC_SLEEP_int;
      end
  
  always @(negedge RESETn or posedge CLK)
      begin
        if (~RESETn) MBC_SLEEP_int <= 1'b1;
        else MBC_SLEEP_int <= ~tran_to_wake & MBC_ISOLATE;
      end
  assign MBC_SLEEP = MBC_SLEEP_int & ~(WAKEUP_REQ_ORED | (~MBUS_DIN & (WAKEUP_REQ_ORED | MBC_SLEEP_int)));
  
  always @(negedge RESETn or posedge CLK)
      begin
        if (~RESETn) MBC_RESET <= 1'b1;
        else MBC_RESET <= MBC_ISOLATE;
      end
endmodule

