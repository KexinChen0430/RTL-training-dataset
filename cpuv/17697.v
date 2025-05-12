module top ;
  reg clk ;
  reg [11:0] x_os_integ, y_os_integ;
  reg [5:0] x_os, y_os;
  initial
	  begin
	  clk = 1'h0 ;
    x_os = 6'h01;
    y_os = 6'h3f;
    x_os_integ = 12'h000;
    y_os_integ = 12'h000;
	  end
  initial
	  begin
	#60; 
	  forever #3 clk = ~clk ; 
	end
  always @( posedge clk )
    begin
    x_os_integ <= x_os_integ + {{6{x_os[5]}}, {x_os[5:0]}};
    y_os_integ <= y_os_integ + {{6{y_os[5]}}, {y_os[5:0]}};
    $display ("%x %x", x_os_integ, y_os_integ);
    end
  initial
    begin
    #200 $finish(0); 
    end
endmodule