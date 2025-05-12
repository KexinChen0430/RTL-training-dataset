module main;
   wire [31:0] A;
   wire [24:0] B;
   reg [15:0]  C;
   assign      A = B;
   assign      B = C;
   initial begin
      C = 0;
      #1 if (A !== 32'h0) begin
	 $display("FAILED -- A === %h", A);
	 $finish;
      end
      C = -1;
      #1 if (A !== 32'h00_00_ff_ff) begin
	 $display("FAILED -- A == %h instead of 0000ffff", A);
	 $finish;
      end
      $display("PASSED");
   end
endmodule