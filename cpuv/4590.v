module at_the_start;
	always begin
    	#2.5 clock = 0;
    	#2.5 clock = 1;
    end
	RegFileWW rg (
		rd1_d,rd2_d,wr_d,r1_addr,r2_addr,w_addr,r1_en,r2_en,
		wr_en,wrbytn,clock);
	initial
	begin
		$display($time, " << Starting the simulation >>");
		$readmemb("testfile.bit",r);
		$display($time, " << Finishing the simulation >>");
		$finish;
	end
endmodule