module main; 
   reg [7:0] x, y; 
   initial begin 
      x = -4; 
      if (x !== 8'hfc) begin
	 $display("FAILED -- x = -4 --> %b", x);
	 $finish; 
      end
      x = 4; 
      if (x !== 8'h04) begin
	 $display("FAILED");
	 $finish; 
      end
      y = -x; 
      if (y !== 8'hfc) begin
	 $display("FAILED -- y = -%b --> %b", x, y);
	 $finish; 
      end
      $display("PASSED");
   end 
endmodule 