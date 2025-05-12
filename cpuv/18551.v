module t (   
   fastclk, clk
   );
`ifdef EDGE_DETECT_STYLE	
 `define posstyle posedge  
 `define negstyle negedge
`else
 `define posstyle  
 `define negstyle
`endif
   input fastclk;  
   input clk;  
   reg [7:0] data;  
   reg [7:0] data_a;  
   reg [7:0] data_a_a;  
   reg [7:0] data_a_b;  
   reg [7:0] data_b;  
   reg [7:0] data_b_a;  
   reg [7:0] data_b_b;  
   reg [8*6-1:0] check [100:0];  
   wire [8*6-1:0] compare = {data_a,data_a_a,data_b_a,data_b,data_a_b,data_b_b};  
   initial begin  
      check[7'd19] = {8'h0d, 8'h0e, 8'h0e, 8'h0d, 8'h0e, 8'h0e};
   end
   always @ (`posstyle clk  or data) begin  
      if (clk) begin
	 data_a <= data + 8'd1;  
      end
   end
   always @ (`posstyle clk  or data_a) begin  
      if (clk) begin
	 data_a_a <= data_a + 8'd1;  
      end
   end
   always @ (`posstyle clk  or data_b) begin  
      if (clk) begin
	 data_b_a <= data_b + 8'd1;  
      end
   end
   always @ (`negstyle clk  or data or data_a) begin  
      if (~clk) begin
	 data_b <= data + 8'd1;  
	 data_a_b <= data_a + 8'd1;  
	 data_b_b <= data_b + 8'd1;  
      end
   end
   integer cyc; initial cyc = 0;  
   always @ (posedge fastclk) begin  
      cyc <= cyc+1;  
`ifdef TEST_VERBOSE
      $write("%d  %x %x %x  %x %x %x\n",cyc,data_a,data_a_a,data_b_a,data_b,data_a_b,data_b_b);  
`endif
      if (cyc>=19 && cyc<36) begin  
	 if (compare !== check[cyc]) begin
	    $write("[%0t] Mismatch, got=%x, exp=%x\n", $time, compare, check[cyc]);  
	    $stop;
	 end
      end
      if (cyc == 10) begin
	 data <= 8'd12;  
      end
      if (cyc == 20) begin
	 data <= 8'd20;  
      end
      if (cyc == 30) begin
	 data <= 8'd30;  
      end
      if (cyc == 40) begin
	 $write("*-* All Finished *-*\n");  
	 $finish;  
      end
   end
endmodule  