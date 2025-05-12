module RAM256 ( CLK, ED,WE ,ADDR ,DI ,DO );
	`FFT256paramnb
	output [nb-1:0] DO ;
	reg [nb-1:0] DO ;
	input CLK ;
	wire CLK ;
	input ED;
	input WE ;
	wire WE ;
	input [7:0] ADDR ;
	wire [7:0] ADDR ;
	input [nb-1:0] DI ;
	wire [nb-1:0] DI ;
	reg [nb-1:0] mem [255:0];
	reg [7:0] addrrd;
	always @(posedge CLK) begin
			if (ED) begin
					if (WE)		mem[ADDR] <= DI;
					addrrd <= ADDR;	         
					DO <= mem[addrrd];	   
				end
		end
endmodule