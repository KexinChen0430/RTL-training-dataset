module tb_xor2_2bit();
	wire [1:0] y;				
	reg [1:0] a;				
	reg [1:0] b;				
	xor2_2bit xor22 (
		a,b,y);
	initial
	begin
		$display(" << Starting the simulation >>");
		a = 2'd0;
		b = 2'd0;
		#10
		a = 2'd0;
		b = 2'd1;
		#10
		a = 2'd1;
		b = 2'd0;
		#10
		a = 2'd1;
		b = 2'd1;
		#10
		a = 2'd2;
		b = 2'd0;
		#10
		a = 2'd0;
		b = 2'd2;
		#10
		a = 2'd1;
		b = 2'd2;
		#10
		a = 2'd2;
		b = 2'd1;
		#10
		a = 2'd2;
		b = 2'd2;
		#10
		a = 2'd3;
		b = 2'd0;
		#10
		a = 2'd0;
		b = 2'd3;
		#10
		a = 2'd3;
		b = 2'd1;
		#10
		a = 2'd1;
		b = 2'd3;
		#10
		a = 2'd3;
		b = 2'd2;
		#10
		a = 2'd2;
		b = 2'd3;
		#10
		a = 2'd3;
		b = 2'd3;
		#20;
		$display(" << Finishing the simulation >>");
		$finish;
	end
endmodule