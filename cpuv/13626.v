module  altpcie_reconfig_4sgx_mux_46a 
(
	data, 
	result, 
	sel) ; 
input   [1:0]  data; 
output   [0:0]  result; 
input   [0:0]  sel; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri0   [1:0]  data; 
	tri0   [0:0]  sel; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	wire	wire_l1_w0_n0_mux_dataout; 
	wire  [1:0]  data_wire; 
	wire  [0:0]  result_wire_ext; 
	wire  [0:0]  sel_wire; 
	assign		wire_l1_w0_n0_mux_dataout = (sel_wire[0] === 1'b1) ? data_wire[1] : data_wire[0]; 
	assign
		data_wire = {data}, 
		result = result_wire_ext, 
		result_wire_ext = {wire_l1_w0_n0_mux_dataout}, 
		sel_wire = {sel[0]}; 
endmodule 