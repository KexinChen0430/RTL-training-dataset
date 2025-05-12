module at the start 
	 */
	always begin 
    	#2.5 clock = 0; 
    	#2.5 clock = 1; 
    end
	RegFileWW rg ( 
		rd1_d,rd2_d,wr_d,r1_addr,r2_addr,w_addr,r1_en,r2_en,
		wr_en,wrbytn,clock); 
	initial
	begin
		$sdf_annotate("../sdf/RegFileWW.sdf",rg,"TYPICAL", "1.0:1.0:1.0", "FROM_MTM"); 
		$display($time, " << Starting the simulation >>"); 
		$readmemb("testfile.bit",r); 
		#20
		wr_d=128'h12fec60caef787897ea12fec60cae787897eac22354; 
		r1_addr=5'd10; 
		r2_addr=5'd11; 
		w_addr=5'd0; 
		wrbytn=16'hff; 
		r1_en=0; 
		r2_en=0; 
		wr_en=1; 
		#20
		#20
		wr_d=128'd12345; 
		r1_addr=5'd0; 
		r2_addr=5'd7; 
		w_addr=5'd20; 
		wrbytn=16'hffff; 
		r1_en=1; 
		r2_en=1; 
		wr_en=0; 
		#20
		#30
		$display($time, " << Finishing the simulation >>"); 
		$finish; 
	end
endmodule 