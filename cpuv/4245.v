module '%s' has multiple valid bits active in the same cycle!",INSTANCE_NAME);$finish(); end end
  wire [1:0] unnamedcallArbitrate5470USEDMULTIPLEcallArbitrate;
  assign unnamedcallArbitrate5470USEDMULTIPLEcallArbitrate = {(pushPop_valid||reset),((pushPop_valid)?(SR31):((1'd0)))};
  always @ (posedge CLK) begin 
    if ((unnamedcallArbitrate5470USEDMULTIPLEcallArbitrate[1]) && CE) begin 
      SR32 <= (unnamedcallArbitrate5470USEDMULTIPLEcallArbitrate[0]); 
    end 
  end
  assign pushPop_out = SR32;
endmodule