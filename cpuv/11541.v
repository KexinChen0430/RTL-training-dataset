module tb_arrmul();
wire [0:127] res;
reg [0:127] r_A;
reg [0:127] r_B;
	reg [0:1] c_ww;
	reg [0:4] a_op;
reg [0:127] e_r;
	arrmul am (
		r_A,r_B,c_ww,a_op,res);
	initial
	begin
		$display($time, " << Starting the simulation >>");
		r_A=128'h0102030405060708090aff0c0dff0fff;
		r_B=128'h01010202030303031004040508000fff;
		e_r=128'h00020008001200180028003c0000fe01;
		c_ww=(`w8+2'b01);
		a_op=`aluwmulou;
		#10
		r_A=128'h0001000200000008000f10bff103ffff;
		r_B=128'h0002000400060008000c001000120014;
		e_r=128'h000000080000004000010bf00013ffec;
		c_ww=(`w16+2'b01);
		a_op=`aluwmulou;
		#30
		$display($time, " << Finishing the simulation >>");
		$finish;
	end
endmodule