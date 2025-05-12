module ReadWrite#
(
	parameter[ 3 : 0 ]ReadState = 0,		
	parameter[ 3 : 0 ]ProcessState = 1,		
	parameter[ 3 : 0 ]WriteState = 2
)
(
	input Clock,	
	input Reset,	
	input[ `size_char - 1 : 0 ]R,	
	input[ `size_char - 1 : 0 ]G,	
	input[ `size_char - 1 : 0 ]B,	
	output reg[ `size_char - 1 : 0 ]R_out,	
	output reg[ `size_char - 1 : 0 ]G_out,	
	output reg[ `size_char - 1 : 0 ]B_out	
);
	reg[ `size_int - 1 : 0 ]ScaleR[ 0 : `SumPixel - 1 ];
	reg[ `size_int - 1 : 0 ]ScaleG[ 0 : `SumPixel - 1 ];
	reg[ `size_int - 1 : 0 ]ScaleB[ 0 : `SumPixel - 1 ];
	reg[ 3 : 0 ]StateNow;
	reg[ 3 : 0 ]StateNext;
	integer	ReadIndex;
	integer WriteIndex;
	always@( posedge Clock )
	begin
		if( Reset == 1'b1 )
		begin
			ReadIndex = 0;
			WriteIndex = 0;
			StateNext = ReadState;
		end
	end
	always@( StateNext )
		StateNow = StateNext;
	always@( posedge Clock )
	begin
		if( StateNow == ReadState )
		begin
			ScaleR[ ReadIndex ] = R << `ScaleBit;
			ScaleG[ ReadIndex ] = G << `ScaleBit;
			ScaleB[ ReadIndex ] = B << `ScaleBit;
			ReadIndex = ReadIndex + 1;
			if( ReadIndex == `SumPixel )
				StateNext = ProcessState;
		end
		else if( StateNow == WriteState )
		begin
			if( WriteIndex < `SumPixel )
			begin
				R_out = ScaleR[ WriteIndex ] >> `ScaleBit;
				G_out = ScaleG[ WriteIndex ] >> `ScaleBit;
				B_out = ScaleB[ WriteIndex ] >> `ScaleBit;
				WriteIndex = WriteIndex + 1;
			end
		end
	end
	always@( StateNow )
	begin
		case( StateNow )
			ProcessState:
			begin
				StateNext = WriteState;
			end
		endcase
	end
endmodule