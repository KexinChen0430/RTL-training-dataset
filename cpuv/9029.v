module.
	PC pc (.clk(clk), .npc(npc), .PC(pcout));
	initial begin
		npc = 0;
		clk = 0;
		#20;
		npc = npc + 1;
		#20;
		npc = npc + 1;
		#20;
		npc = npc + 1;
		#20;
		npc = npc + 1;
		#20;
		npc = npc + 1;
		#40 $finish;
	end
	always @ (posedge clk)
	begin
		$display("At t = %0d\tnpc = %h\t\tpc = %h", $time, npc, pcout);
	end
	initial begin
		forever begin
			#10 clk = ~clk;
		end
	end
endmodule