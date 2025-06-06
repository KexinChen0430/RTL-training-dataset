module mult_block ( 
	dataa, 
	datab, 
	signa, 
	signb, 
	product 
);
parameter width_a = 1; 
parameter width_b = 1; 
parameter normalized_width = 1; 
parameter dataa_signed = "use_port"; 
parameter datab_signed = "use_port"; 
localparam width_product = width_a + width_b; 
localparam norm_width_a = ( width_a < normalized_width ) ? normalized_width + 1 : width_a + 1; 
localparam norm_width_b = ( width_b < normalized_width ) ? normalized_width + 1 : width_b + 1; 
localparam norm_width_product = norm_width_a + norm_width_b; 
input [ width_a - 1 : 0 ] dataa; 
input [ width_b - 1 : 0 ] datab; 
input signa; 
input signb; 
output [ width_product - 1 : 0 ] product; 
wire signed [ norm_width_a - 1 : 0 ] signed_a; 
wire signed [ norm_width_b - 1 : 0 ] signed_b; 
wire signed [ norm_width_product - 1 : 0 ] signed_product; 
wire [ norm_width_a - 1 : 0 ] a_t1; 
wire [ norm_width_a - 1 : 0 ] a_t2; 
wire [ norm_width_b - 1 : 0 ] b_t1; 
wire [ norm_width_b - 1 : 0 ] b_t2; 
generate 
        if( dataa_signed == "use_port" ) begin 
			assign signed_a[ norm_width_a - 1 ] = signa ? dataa[width_a-1] : 1'b0; 
        end
        else if( dataa_signed == "true" ) begin 
			assign signed_a[ norm_width_a - 1 ] = dataa[width_a-1]; 
        end
        else if( dataa_signed == "false" ) begin 
			assign signed_a[ norm_width_a - 1 ] = 1'b0; 
        end
        if( datab_signed == "use_port" ) begin 
			assign signed_b[ norm_width_b - 1 ] = signb ? datab[width_b-1] : 1'b0; 
        end
        else if( datab_signed == "true" ) begin 
			assign signed_b[ norm_width_b - 1 ] = datab[width_b-1]; 
        end
        else if( datab_signed == "false" ) begin 
			assign signed_b[ norm_width_b - 1 ] = 1'b0; 
        end
		if( width_a < normalized_width ) begin 
			assign signed_a[ norm_width_a - width_a - 2 : 0 ] = { norm_width_a - width_a - 1 {1'b0} }; 
		end
		if( width_b < normalized_width ) begin 
			assign signed_b[ norm_width_b - width_b - 2 : 0 ] = { norm_width_b - width_b - 1 {1'b0} }; 
		end
	endgenerate 
	assign signed_a[ norm_width_a - 2 : norm_width_a - width_a - 1 ] = dataa; 
	assign signed_b[ norm_width_b - 2 : norm_width_b - width_b - 1 ] = datab; 
	assign signed_product = signed_a * signed_b; 
	assign product = signed_product[ norm_width_product - 3 : norm_width_product - width_product - 2 ]; 
endmodule 