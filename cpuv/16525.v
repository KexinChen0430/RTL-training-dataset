module t ( 
   passed, 
   clk, fastclk, reset_l 
   );
   input clk; 
   input fastclk; 
   input reset_l; 
   output passed; 
   wire [20:0] passedv; 
   wire   passed = &passedv; 
   assign passedv[0] = 1'b1; 
   t_inst  tinst 
     (.passed		(passedv[6]), 
      .clk				(clk), 
      .fastclk				(fastclk)); 
   t_netlist tnetlist 
     (.passed		(passedv[20]), 
      .also_fastclk	(fastclk), 
      .fastclk				(fastclk)); 
endmodule