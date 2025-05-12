module main; 
  reg [3:0] a, b, c, t; 
  (* ivl_combinational *) 
  always @(a, b) begin 
     t = a + b; 
     c = 4'd1 + ~t; 
  end
  (* ivl_synthesis_off *) 
  initial begin 
     a = 1; 
     for (b = 0 ;  b < 4'hf ;  b = b + 1) begin 
	#1 if (c !== -(a + b)) begin 
	   $display("FAILED -- a=%b, b=%b, t=%b, c=%b", a, b, t, c); 
	   $finish; 
	end
     end
     $display("PASSED"); 
  end 
endmodule 