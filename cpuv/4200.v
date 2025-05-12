module ivltest(); 
   reg clk; 
   reg val; 
   reg c2; 
   initial
     begin
	clk <= 0; 
	val <= 0; 
	c2 <= 0; 
	forever
	  #10 clk <= ~clk; 
     end
   initial
     $dumpvars;
   initial
     #1000 $finish;
   initial
     begin
	$frsim_system;
     end
   always @ (posedge clk)
     c2 <= ~c2; 
endmodule 