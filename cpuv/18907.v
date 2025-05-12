module t (
   clk
   );
   input clk;
   integer cyc=1;
   integer a, b, c, d, e, f, g, h, i, j, k, l;
   always @ (posedge clk) begin
      cyc <= cyc + 1;
      unique0 if (cyc > 5)
	a <= 17;
      unique0 if (cyc < 3)
	b <= 17;
      else
	b <= 19;
      unique0 if (cyc < 3)
	c <= 17;
      else if (cyc > 3)
	c <= 19;
      unique0 if (cyc < 3)
	d <= 17;
      else if (cyc > 3)
	d <= 19;
      else
	d <= 21;
      unique if (cyc < 3)
	f <= 17;
      else
	f <= 19;
      unique if (cyc < 3)
	g <= 17;
      else if (cyc >= 3)
	g <= 19;
      unique if (cyc < 3)
	h <= 17;
      else if (cyc > 3)
	h <= 19;
      else
	h <= 21;
`ifdef FAILING_ASSERTION1
      $display("testing fail 1: %d", cyc);
      unique0 if (cyc < 3)
	i <= 17;
      else if (cyc < 5)
	i <= 19;
`endif
`ifdef FAILING_ASSERTION2
      unique if (cyc < 3)
	j <= 17;
      else if (cyc < 5)
	j <= 19;
`endif
`ifdef FAILING_ASSERTION3
      unique if (cyc > 1000)
	k <= 17;
      else if (cyc > 2000)
	k <= 19;
`endif
`ifdef FAILING_ASSERTION4
      unique if (cyc > 5)
	l <= 17;
`endif
      if (cyc==10) begin
	 $write("*-* All Finished *-*\n");
	 $finish;
      end
   end
endmodule