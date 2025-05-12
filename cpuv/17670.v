module '%s' has multiple valid bits active in same cycle!",INSTANCE_NAME);$finish(); end end
wire [1:0] unnamedcallArbitrate305USEDMULTIPLEcallArbitrate;
assign unnamedcallArbitrate305USEDMULTIPLEcallArbitrate = {
    (pushPop_valid || reset),
    ((pushPop_valid) ? (sr_input) : ((1'd0)))
};
always @ (posedge CLK) begin
    if ((unnamedcallArbitrate305USEDMULTIPLEcallArbitrate[1]) && CE) begin
        SR1 <= (unnamedcallArbitrate305USEDMULTIPLEcallArbitrate[0]);
    end
end
assign pushPop_out = SR1;
endmodule