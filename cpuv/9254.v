module t_chg (
   passed,
   clk, fastclk
   );
   input clk;                 
   input fastclk;             
   output passed;             
   reg passed;                
   initial passed = 0;        
   integer _mode;             
   initial _mode=0;           
   reg  [31:0] ord1;          
   initial ord1 = 32'h1111;   
   wire [31:0] ord2;          
   reg  [31:0] ord3;          
   wire [31:0] ord4;          
   wire [31:0] ord5;          
   wire [31:0] ord6;          
   wire [31:0] ord7;          
   t_chg_a a (                
	      .a(ord1), .a_p1(ord2),
	      .b(ord4), .b_p1(ord5),
	      .c(ord3), .c_p1(ord4),
	      .d(ord6), .d_p1(ord7)
	      );
   assign      ord6 = ord5 + 1; 
   always @ (ord2) ord3 = ord2 + 1; 
   always @ (fastclk) begin 
      if (_mode==1) begin
      end
   end
   always @ (posedge clk) begin 
      if (_mode==0) begin
	 $write("[%0t] t_chg: Running\n", $time); 
	 _mode<=1; 
	 ord1 <= 1; 
      end
      else if (_mode==1) begin
	 _mode<=2; 
	 if (ord7 !== 7) $stop; 
	 $write("[%0t] t_chg: Passed\n", $time); 
	 passed <= 1'b1; 
      end
   end
endmodule