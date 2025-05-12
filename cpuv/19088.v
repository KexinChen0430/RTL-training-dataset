module test;
  reg  clk;
  reg [31:0] x;
  reg [31:0] y;
  reg error;
  always@(posedge clk)
        x <= -y;
  always #2 clk = ~clk;
  initial
    begin
       clk = 0;
       error = 0;
       y = 0;
       #10;
       if( x !== 32'h0)
         begin
           error = 1;
	   $display("FAILED - X should still be 0, and it's not");
         end
       #10;
       y = 32'h11111111;
       #10;
       if(x !== 32'heeee_eeef)
         begin
           error = 1;
	   $display("FAILED - X should still be EEEE_EEEF, rather x=%h",x);
	 end
       #10;
       if(error == 0)
	  $display("PASSED");
       $finish ;
    end
endmodule