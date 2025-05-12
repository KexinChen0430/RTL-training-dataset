module <module_name> (
);
assign tck_o = (drck & debug_select_o & !update_bscan);
always @(posedge update_bscan or posedge capture_dr_o or negedge debug_select_o) begin
	if(update_bscan) update_out <= 1'b1;
	else if(capture_dr_o) update_out <= 1'b0;
	else if(!debug_select_o) update_out <= 1'b0;
end
assign update_dr_o = update_out;
`endif
`endif
`endif
`endif
`endif
`endif
`endif
endmodule