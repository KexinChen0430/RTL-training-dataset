module led7(input [3:0] mod0,	output reg [6:0] led); 
always begin 
	case(mod0)	  
		0 : led = 7'b100_0000; 
		1 : led = 7'b111_1001; 
		2 : led = 7'b010_0100; 
		3 : led = 7'b011_0000; 
		4 : led = 7'b001_1001; 
		5 : led = 7'b001_0010; 
		6 : led = 7'b000_0010; 
		7 : led = 7'b111_1000; 
		8 : led = 7'b000_0000; 
		9 : led = 7'b001_0000; 
		default : led = 7'b111_1111; 
	endcase 
end 
endmodule 