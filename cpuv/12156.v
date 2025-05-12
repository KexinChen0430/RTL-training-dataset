module `$name` ( 
	input wire [`$inputWidth`-1:0] i_write_data, 
	output reg [`$r`-1:0] o_write_edc, 
	input wire [`$inputWidth`-1:0] i_stored_data, 
	input wire [`$r`-1:0] i_stored_edc, 
``if {$ecc} {`` 
	output reg [`$inputWidth`-1:0] o_read_data, 
	output reg o_correction, 
``}``
	output reg o_detection 
``if {$ecc} {``, this happens only if the error is not correctable``}``
);
`hammingCodeVerilogFunction2 $hammingCodeDict $ecc` 
wire [`$r`-1:0] stored_data_edc = `$funcName`(i_stored_data); 
wire [`$r`-1:0] syndroms = i_stored_edc ^ stored_data_edc; 
``if {$ecc} {`` 
	reg uncorrectable_error; 
	reg [`$inputWidth`-1:0] correction_pattern; 
	always @* begin 
		{o_detection,o_correction,correction_pattern} = `$eccFuncName`(syndroms,CORRECT_EDC_SINGLE_BIT_ERRORS); 
		o_read_data = i_stored_data ^ correction_pattern; 
	end
``} else {`` 
	always @* o_detection = |syndroms; 
``}``
endmodule 