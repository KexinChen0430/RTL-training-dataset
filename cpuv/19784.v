module test;
   task writeInto;
      input [31:0] x;
      begin
	 $display("x=%h", x);
	 if (x[31:10] !== 22'd0) begin
	    $display("FAILED -- x is %b", x);
	    $finish;
	 end
      end
   endtask
   reg [7:0] y;
   reg [31:0] y1;
   initial begin
      y1 = 512;
      y = 4;
      writeInto(y1);
      writeInto(y);
      $display("PASSED");
  end
endmodule