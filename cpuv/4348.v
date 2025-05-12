module '%s' has multiple valid bits active in same cycle!",INSTANCE_NAME);$finish(); end end
  wire [1:0] unnamedcallArbitrate5798USEDMULTIPLEcallArbitrate;
  assign unnamedcallArbitrate5798USEDMULTIPLEcallArbitrate = {
    (pushPop_valid || reset),
    ((pushPop_valid) ? (SR4) : ((1'd0)))
  };
  always @ (posedge CLK) begin
    if ((unnamedcallArbitrate5798USEDMULTIPLEcallArbitrate[1]) && CE) begin
      SR5 <= (unnamedcallArbitrate5798USEDMULTIPLEcallArbitrate[0]);
    end
  end
  assign pushPop_out = SR5;
endmodule