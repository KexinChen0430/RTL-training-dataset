module main;
   parameter vec = 16'b0000_1001_0111_1010;
   initial begin
      if (vec[0] !== 0) begin
	 $display("FAILED -- %b[0] !== 0", vec);
	 $finish;
      end
      if (vec[1] !== 1) begin
	 $display("FAILED -- %b[1] !== 1", vec);
	 $finish;
      end
      if (vec[3:1] !== 3'b101) begin
	 $display("FAILED -- %b[3:1] !== b101", vec);
	 $finish;
      end
      $display("PASSED");
   end
endmodule