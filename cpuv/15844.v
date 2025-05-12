module body
	assign clk = cpol ^ cpha ^ sck;
	always @(posedge clk)
	  sri <= #1 {sri[6:0],di};
	always @(posedge clk)
	  if (&bit_cnt)
	 	    sro <= #1 mem[mem_adr_read];
	  else
	    sro <= #1 {sro[6:0],1'bx};
	assign do = csn==0 ? sro[7] : 1'bz;
	always @(posedge clk, posedge csn)
	  if(csn)
	    bit_cnt <= #1 3'b111;
	  else
	    bit_cnt <= #1 bit_cnt - 3'h1;
        always @(posedge clk)
	  ld <= #1 ~(|bit_cnt);
	always @(negedge clk)
          if (ld) begin
	    mem[mem_adr] <= #1 sri;
	    mem_adr      <= #1 mem_adr + 1'b1;
		if (debug==1)
				$display("slave: received %8b", sri);
	  end
	initial
	begin
	  bit_cnt=3'b111;
	  mem_adr = 0;
	  sro = mem[mem_adr_read];
	end
	always @(negedge csn)
			if (csn==1'b0) $display("slave: my ID is %2d", ID);
endmodule