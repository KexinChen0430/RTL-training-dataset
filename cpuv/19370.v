module FFD_POSEDGE_SYNCRONOUS_RESET_INIT # ( parameter SIZE=`WIDTH ) 
(
	input wire				Clock, 
	input wire				Reset, 
	input wire				Enable, 
	input wire [SIZE-1:0]   iInitial, 
	input wire [SIZE-1:0]	D, 
	output reg [SIZE-1:0]	Q 
);
always @ (posedge Clock) 
begin
	if ( Reset ) 
		Q <= iInitial; 
	else 
	begin
		if (Enable) 
			Q <= D; 
	end
end
endmodule 