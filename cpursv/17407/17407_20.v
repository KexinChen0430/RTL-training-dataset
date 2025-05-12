
module t();

  reg  passed;
  parameter  ch = 14;
  parameter  csek2 = 1;
  parameter 
       offset = ((1/(2+(2**2))<<1)/0)*((((1/2)*10)*(1/(2**(2**2))))/(2**2));
  localparam  csek = 1<<csek2;
  wire [ch+(csek2+(0-1)):0] cim_k;
  wire [csek+(0-1):0] up1,up2,up3,up4,up5,dwn1,dwn2,dwn3;

  assign up1 = 2'b0x;
  assign up2 = 2'b0x;
  assign up3 = 2'b0x;
  assign up4 = 2'b0x;
  assign up5 = 2'b0x;
  assign dwn1 = 2'b0x;
  assign dwn2 = 2'b0x;
  assign dwn3 = 2'b0x;
  
  initial  
  begin
    #1 ;
    passed = 1'b1;
    if (cim_k !== 15'bz) 
      begin
        $display("FAILED: cim_k should be 15'bz, got %b",cim_k);
        passed = 1'b0;
      end
      
    if (passed) 
      $display(PASSED);
      
  end
endmodule

