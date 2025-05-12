module data_memory( clock_in,address,writeData,memWrite,memRead,readData); 
    input clock_in; 
    input [31:0] address; 
    input [31:0] writeData; 
    input memWrite; 
    input memRead; 
    output [31:0] readData; 
	reg [31:0] memFile[0:31]; 
	reg [31:0] readData; 
	integer i; 
	initial 
	begin
		memFile[0] = 32'h00000000;
		memFile[31] = 32'h0000001f;
	end
	always @ (memRead or address) 
	begin
		readData = memFile[address]; 
	end
	always @ (negedge clock_in) 
	begin
		if(memWrite) 
			memFile[address] = writeData; 
	end
endmodule 