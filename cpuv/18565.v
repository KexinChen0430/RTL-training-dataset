module test; 
   supply0 gnd; 
   supply1 vdd; 
   initial begin 
      #1; 
      if (gnd !== 0) begin
	 $display("FAILED -- gnd == %b", gnd);
	 $finish; 
      end
      if (vdd !== 1) begin
	 $display("FAILED -- vdd == %b", vdd);
	 $finish; 
      end
      $display("PASSED");
   end 
endmodule 