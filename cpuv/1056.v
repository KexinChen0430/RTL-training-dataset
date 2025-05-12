module pippo_operandmuxes(
	rf_dataa, rf_datab, wb_fwd,	imm,
	sel_a, sel_b,
	bus_a, bus_b
);
parameter width = `OPERAND_WIDTH;
input	[width-1:0]		rf_dataa;    
input	[width-1:0]		rf_datab;    
input	[width-1:0]		wb_fwd;      
input	[width-1:0]		imm;         
input	[`OPSEL_WIDTH-1:0]	sel_a;       
input	[`OPSEL_WIDTH-1:0]	sel_b;       
output	[width-1:0]		bus_a;       
output	[width-1:0]		bus_b;       
reg	[width-1:0]		bus_a;       
reg	[width-1:0]		bus_b;       
always @(wb_fwd or rf_dataa or sel_a) begin
`ifdef pippo_ADDITIONAL_SYNOPSYS_DIRECTIVES
	casex (sel_a)	
`else
	casex (sel_a)	
`endif
		`OPSEL_WBFWD:  
			bus_a = wb_fwd;
		`OPSEL_RF:     
			bus_a = rf_dataa;
		default:       
			bus_a = rf_dataa;
            `ifdef pippo_VERBOSE
            		$display("%t: WARNING: OperandMux enter default case %h", $time);
            `endif
	endcase
end
always @(imm or wb_fwd or rf_datab or sel_b) begin
`ifdef pippo_ADDITIONAL_SYNOPSYS_DIRECTIVES
	casex (sel_b)	
`else
	casex (sel_b)	
`endif
		`OPSEL_IMM:    
			bus_b = imm;
		`OPSEL_WBFWD:  
			bus_b = wb_fwd;
		`OPSEL_RF:     
			bus_b = rf_datab;
		default:       
			bus_b = rf_datab;
            `ifdef pippo_VERBOSE
            		$display("%t: WARNING: OperandMux enter default case %h", $time);
            `endif
	endcase
end
endmodule 