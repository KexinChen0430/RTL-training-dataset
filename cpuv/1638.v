module tb_alu();
	wire [0:127] res;
	reg [0:127] r_A;
	reg [0:127] r_B;
	reg [0:1] c_ww;
	reg [0:4] a_op;
	reg [0:127] e_r;
	alu a_l_u (
		r_A,r_B,c_ww,a_op,res);
	initial
	begin
		$display($time, " << Starting the simulation >>");
		r_A=128'h0402030405060708f00a0b0cff0eff00;
		r_B=128'h03010202030303031004f505ff09fe10;
		e_r=128'h000c0006000f00150f000a87fe01fd02;
		c_ww=`w8;
		a_op=`aluwmuleu;
		#10
		r_A=128'h000100020000ffff000f10bff103ffff;
		r_B=128'h000200040006ffff000c100000120014;
		e_r=128'h0000000200000000000000b40010f236;
		c_ww=`w16;
		a_op=`aluwmuleu;
		#10
		r_A=128'h0102030405060708090aff0c0dff0fff;
		r_B=128'h01010202030303031004040508000fff;
		e_r=128'h00020008001200180028003c0000fe01;
		c_ww=`w8;
		a_op=`aluwmulou;
		#10
		r_A=128'h0001000200000008000f10bff103ffff;
		r_B=128'h0002000400060008000c001000120014;
		e_r=128'h000000080000004000010bf00013ffec;
		c_ww=`w16;
		a_op=`aluwmulou;
		#10
		r_A=128'h0180010501f9015301040100013c0100;
		r_B=128'h017f010901fa010001fd01f101b80100;
		e_r=128'hc080002d002a0000fff40000ef200000;
		c_ww=`w8;
		a_op=`aluwmulos;
		#10
		r_A=128'h1111000211118000111120541111fff9;
		r_B=128'hffff0004ffff7fffffff0000fffffffd;
		e_r=128'h00000008c00080000000000000000015;
		c_ww=`w16;
		a_op=`aluwmulos;
		#10
		r_A=128'h80010501f9015301040100013c010001;
		r_B=128'h7f010901fa010001fd01f101b8010001;
		e_r=128'hc080002d002a0000fff40000ef200000;
		c_ww=`w8;
		a_op=`aluwmules;
		#10
		r_A=128'h000211118000111120541111fff91111;
		r_B=128'h0004ffff7fffffff0000fffffffdffff;
		e_r=128'h00000008c00080000000000000000015;
		c_ww=`w16;
		a_op=`aluwmules;
		#30
		$display($time, " << Finishing the simulation >>");
		$finish;
	end
endmodule