module MakeReset0 ( 
  CLK, 
  RST, 
  ASSERT_IN, 
  ASSERT_OUT, 
  OUT_RST 
  );
   parameter init = 1 ; 
   input CLK ; 
   input RST ; 
   input ASSERT_IN ; 
   output ASSERT_OUT ; 
   output OUT_RST ; 
   reg rst ; 
   assign ASSERT_OUT =  rst == `BSV_RESET_VALUE ; 
   assign OUT_RST = rst ; 
   always@(posedge CLK or `BSV_RESET_EDGE RST) begin 
      if (RST == `BSV_RESET_VALUE) 
        rst <= `BSV_ASSIGNMENT_DELAY init ? ~ `BSV_RESET_VALUE : `BSV_RESET_VALUE; 
      else 
        begin
           if (ASSERT_IN) 
             rst <= `BSV_ASSIGNMENT_DELAY `BSV_RESET_VALUE; 
           else 
             rst <= `BSV_ASSIGNMENT_DELAY ~ `BSV_RESET_VALUE; 
        end 
   end 
`ifdef BSV_NO_INITIAL_BLOCKS 
`else 
   initial begin 
      #0 ; 
      rst = ~ `BSV_RESET_VALUE ; 
   end 
`endif 
endmodule 