module t(); 
  reg passed; 
  parameter ch = 14; 
  parameter csek2 = 1; 
  parameter offset = 10/0; 
  localparam csek = 1 << csek2; 
  wire [ch + csek2 - 1:0] cim_k; 
  wire [csek - 1:0] up1, up2, up3, up4, up5, dwn1, dwn2, dwn3; 
`ifdef SUPPORT_CONST_OUT_OF_RANGE_IN_IVTEST 
  assign up1 = cim_k[(csek2 + ch)+:csek2]; 
  assign up2 = cim_k[(csek2 + ch + 2)+:csek2]; 
  assign up3 = cim_k[(csek2 + ch - 17)+:csek2]; 
  assign up4 = cim_k[(csek2 + ch - 18)+:csek2]; 
  assign up5 = cim_k[(csek2 + ch - offset)+:csek2]; 
  assign dwn1 = cim_k[(csek2 + ch + 2)-:csek2]; 
  assign dwn2 = cim_k[(csek2 + ch - 17)-:csek2]; 
  assign dwn3 = cim_k[(csek2 + ch - offset)-:csek2]; 
`else 
  assign up1 = 2'b0x; 
  assign up2 = 2'b0x; 
  assign up3 = 2'b0x; 
  assign up4 = 2'b0x; 
  assign up5 = 2'b0x; 
  assign dwn1 = 2'b0x; 
  assign dwn2 = 2'b0x; 
  assign dwn3 = 2'b0x; 
`endif 
  initial begin 
    #1; 
    passed = 1'b1; 
    if (cim_k !== 15'bz) begin 
      $display("FAILED: cim_k should be 15'bz, got %b", cim_k); 
      passed = 1'b0; 
    end
    if (passed) $display("PASSED"); 
  end 
endmodule 