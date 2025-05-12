module tb_decoder4to16();
	wire [15:1] dout; 
	reg [3:0] din; 
	decoder4to16 dec4to16 (
		.din(din), 
		.dout(dout) 
	);
	initial
	begin
		$display(" << Starting the simulation >>");
		din = 4'd0; 
		#1; 
		din = 4'd1; 
		#1; 
		din = 4'd2; 
		#1; 
		din = 4'd3; 
		#1; 
		din = 4'd4; 
		#1; 
		din = 4'd5; 
		#1; 
		din = 4'd6; 
		#1; 
		din = 4'd7; 
		#1; 
		din = 4'd8; 
		#1; 
		din = 4'd9; 
		#1; 
		din = 4'd10; 
		#1; 
		din = 4'd11; 
		#1; 
		din = 4'd12; 
		#1; 
		din = 4'd13; 
		#1; 
		din = 4'd14; 
		#1; 
		din = 4'd15; 
		#20; 
		$display(" << Finishing the simulation >>");
		$finish;
	end
endmodule