module Divider 
(
	input[ `size_int - 1 : 0 ]Dividend, 
	input[ `size_int - 1 : 0 ]Divisor, 
	output reg[ `size_int - 1 : 0 ]Q, 
	output reg[ `size_int - 1 : 0 ]Remainder 
);
	integer i; 
	reg[ `size_int - 1 : 0 ]Quotient; 
	reg[ `size_int : 0 ]Partial; 
	reg[ `size_int - 1 : 0 ]div; 
	always@( Dividend or Divisor ) 
	begin
		Quotient = Dividend; 
		div = Divisor; 
		Partial = { `size_int'h00, 1'b0 }; 
		for( i = 0; i < `size_int; i = i + 1 ) 
		begin
			Partial = { Partial[ `size_int - 1 : 0 ], Quotient[ `size_int - 1 ] }; 
			Quotient = { Quotient[ `size_int - 2 : 0 ], 1'b0 }; 
			Partial = Partial + { ~{ 1'b0, div } + 1'b1 }; 
			if( Partial[ `size_int ] == 1'b0 ) 
				Quotient[ 0 ] = 1'b1; 
			else
			begin
				Partial = Partial + div; 
				Quotient[ 0 ] = 1'b0; 
			end
		end
		Remainder = Partial[ `size_int - 1 : 0 ]; 
		if( Remainder * 10 >= Divisor * 5 ) 
			Q = Quotient + 1; 
		else
			Q = Quotient; 
	end
endmodule 