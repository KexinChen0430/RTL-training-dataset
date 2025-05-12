module t (
   clk
   );
   input clk; 
   reg toggle; initial toggle=0;
   integer cyc; initial cyc=1;
   wire [7:0] cyc_copy = cyc[7:0];
   alpha a1 (
	     .clk			(clk),
	     .toggle			(toggle));
   alpha a2 (
	     .clk			(clk),
	     .toggle			(toggle));
   beta  b1 (
	     .clk			(clk),
	     .toggle			(toggle));
   beta  b2 (
	     .clk			(clk),
	     .toggle			(toggle));
   tsk   t1 (
	     .clk			(clk),
	     .toggle			(toggle));
   off   o1 (
	     .clk			(clk),
	     .toggle			(toggle));
   always @ (posedge clk) begin
      if (cyc!=0) begin
	 cyc <= cyc + 1;
	 toggle <= '0;
	 if (cyc==3) begin
	    toggle <= '1;
	 end
	 else if (cyc==5) begin
`ifdef VERILATOR
	    $c("call_task();");
`else
	    call_task();
`endif
	 end
	 else if (cyc==10) begin
	    $write("*-* All Finished *-*\n");
	    $finish;
	 end
      end
   end
   task call_task;
      t1.center_task(1'b1);
   endtask
endmodule