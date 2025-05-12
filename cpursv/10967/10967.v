
module testCPU(Reset_L,startPC,testData);

  input  [31:0] testData;
  output Reset_L;
  output [31:0] startPC;
  reg  Reset_L;
  reg  [31:0] startPC;

  
  initial  
  begin
    Reset_L = 0;
    startPC = 0*4;
    #101 Reset_L = 1;
    #4000 ;
    Reset_L = 0;
    $finish;
  end
endmodule

