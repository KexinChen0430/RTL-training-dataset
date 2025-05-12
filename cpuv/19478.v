module main; 
   reg [7:1] a  = 6'b111111; 
   reg [7:1] b = 6'b000010; 
   integer q; 
   reg [7:1] x; 
   reg	     PCLK = 1; 
   always @(posedge PCLK) 
     for (q=1; q<=7; q=q+1) 
       x[q] <= #1 a[q] & b[q]; 
   always #5 PCLK = !PCLK; 
   initial begin 
      #50 $display("done: x=%b", x); 
      if (x !== 6'b000010) 
	$display("FAILED -- x = %b", x); 
      else
	$display("PASSED"); 
      $finish; 
   end
endmodule 