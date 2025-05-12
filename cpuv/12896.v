module AutoLevel( R, G, B, R_out, G_out, B_out );
	input[ `size_int - 1 : 0 ]R;
	input[ `size_int - 1 : 0 ]G;
	input[ `size_int - 1 : 0 ]B;
	output wire[ `size_int - 1 : 0 ]R_out;
	output wire[ `size_int - 1 : 0 ]G_out;
	output wire[ `size_int - 1 : 0 ]B_out;
	reg[ `size_int - 1 : 0 ]Rtemp;
	reg[ `size_int - 1 : 0 ]Gtemp;
	reg[ `size_int - 1 : 0 ]Btemp;
	always@( R )
	begin
		if( ( R > `LowThreshold ) && ( R < `HighThreshold ) )
			Rtemp = `Scale * ( R - `LowThreshold );
		else if( R <= `LowThreshold ) 
			Rtemp = `MinThreshold;
		else	
			Rtemp = `MaxThreshold;
	end
	always@( G )
	begin
		if( ( G > `LowThreshold ) && ( G < `HighThreshold ) )
			Gtemp = `Scale * ( G - `LowThreshold );
		else if( G <= `LowThreshold ) 
			Gtemp = `MinThreshold;
		else	
			Gtemp = `MaxThreshold;
	end
	always@( B )
	begin
		if( ( B > `LowThreshold ) && ( B < `HighThreshold ) )
			Btemp = `Scale * ( B - `LowThreshold );
		else if( B <= `LowThreshold ) 
			Btemp = `MinThreshold;
		else	
			Btemp = `MaxThreshold;
	end
	assign R_out = Rtemp;
	assign G_out = Gtemp;
	assign B_out = Btemp;
endmodule