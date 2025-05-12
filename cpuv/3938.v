module tb_cencoder();
	wire [1:0] cout;
	reg bin;			
	reg ck;				
	reg rset;			
	conv_encoder enc (
		cout,bin,ck,rset);
	initial
	begin
		$display(" << Starting the simulation >>");
		$display(" << Finishing the simulation >>");
		$finish;
	end
endmodule