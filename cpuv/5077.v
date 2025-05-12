module t (
   clk
   );
   input clk; 
   reg [7:0] cyc; initial cyc=0; 
   reg [31:0] loops; 
   reg [31:0] loops2; 
   integer   i; 
   always @ (posedge clk) begin
      cyc <= cyc+8'd1; 
      if (cyc == 8'd1) begin
	 $write("[%0t] t_loop: Running\n",$time); 
	 loops = 0;
	 loops2 = 0;
	 for (i=0; i<16; i=i+1) begin
	    loops = loops + i;		
	    loops2 = loops2 + i;	
	 end
	 if (i !== 16) $stop;
	 if (loops !== 120) $stop;
	 if (loops2 !== 120) $stop;
	 loops = 0;
	 for (i=0; i<=16; i=i+1) begin
	    loops = loops + 1;
	 end
	 if (i !== 17) $stop;
	 if (loops !== 17) $stop;
	 loops = 0;
	 for (i=0; i<16; i=i+1) begin
	    loops = loops + 1;
	    if (i==7) i=99;	
	 end
	 if (loops !== 8) $stop;
	 loops = 0;
	 for (i=0; i<100000; i=i+1) begin
	    loops = loops + 1;
	 end
	 if (loops !== 100000) $stop;
	 loops = 0;
	 for (i=0; i<=16; i++) begin
	    loops = loops + 1;
	 end
	 if (i !== 17) $stop;
	 if (loops !== 17) $stop;
	 loops = 0;
	 for (i=0; i<=16; ++i) begin
	    loops = loops + 1;
	 end
	 if (i !== 17) $stop;
	 if (loops !== 17) $stop;
	 loops = 0;
	 for (i=16; i>=0; i--) begin
	    loops = loops + 1;
	 end
	 if (i !== -1) $stop;
	 if (loops !== 17) $stop;
	 loops = 0;
	 for (i=16; i>=0; --i) begin
	    loops = loops + 1;
	 end
	 if (i !== -1) $stop;
	 if (loops !== 17) $stop;
	 loops = 0;
	 i = 0;
	 for (; i<10; ++i) ++loops;
	 if (loops !== 10) $stop;
	 loops = 0;
	 i = 0;
	 for (i=0; i<10; ) begin ++loops; ++i; end
	 if (loops !== 10) $stop;
	 loops = 0;
	 i = 0;
	 for (; ; ++i) begin ++loops; break; end
	 if (loops !== 1) $stop;
	 $write("*-* All Finished *-*\n");
	 $finish; 
      end
   end
endmodule