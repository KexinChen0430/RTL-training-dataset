module MakeClock ( CLK, RST,
                   CLK_IN, CLK_IN_EN,
                   COND_IN, COND_IN_EN,
                   CLK_VAL_OUT, COND_OUT,
                   CLK_OUT, CLK_GATE_OUT );
   parameter initVal = 0;
   parameter initGate = 1;
   input  CLK;
   input  RST;
   input  CLK_IN;
   input  CLK_IN_EN;
   input  COND_IN;
   input  COND_IN_EN;
   output CLK_VAL_OUT;
   output COND_OUT;
   (* CLOCK_SIGNAL = "YES" *)
   (* BUFFER_TYPE = "BUFG" *)
   output CLK_OUT;
   output CLK_GATE_OUT;
   (* KEEP = "TRUE" *)
   reg current_clk;
   reg CLK_VAL_OUT;
   reg current_gate;
   reg new_gate;
   always @(posedge CLK or `BSV_RESET_EDGE RST)
   begin
     if (RST == `BSV_RESET_VALUE)
     begin
       current_clk = initVal;
     end
     else
     begin
       if (CLK_IN_EN)
         current_clk = CLK_IN;
     end
   end
   always @(posedge CLK or `BSV_RESET_EDGE RST)
   begin
     if (RST == `BSV_RESET_VALUE)
     begin
       CLK_VAL_OUT <=  `BSV_ASSIGNMENT_DELAY initVal;
     end
     else
     begin
       if (CLK_IN_EN)
         CLK_VAL_OUT <=  `BSV_ASSIGNMENT_DELAY CLK_IN;
     end
   end
   always @(posedge CLK or `BSV_RESET_EDGE RST)
   begin
     if (RST == `BSV_RESET_VALUE)
       new_gate   <=  `BSV_ASSIGNMENT_DELAY initGate;
     else
     begin
       if (COND_IN_EN)
         new_gate <=  `BSV_ASSIGNMENT_DELAY  COND_IN;
     end
   end
   always @( current_clk or new_gate )
     begin
        if (current_clk == 1'b0)
          current_gate  <= `BSV_ASSIGNMENT_DELAY new_gate ;
     end
   assign CLK_OUT      = current_clk && current_gate;
   assign CLK_GATE_OUT = current_gate;
   assign COND_OUT     = new_gate;
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial begin
      #0 ;
      current_clk  = 1'b0 ;
      current_gate = 1'b1 ;
      new_gate     = 1'b1 ;
      CLK_VAL_OUT  = 1'b0;
   end
`endif 
endmodule