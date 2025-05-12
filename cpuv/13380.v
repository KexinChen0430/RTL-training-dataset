module QcmMasterControllerMain myMain(clk, sig, codeSer, codePar, enableSer, enablePar); 
initial begin 
  $display("time, testNum, codeSer, codePar, enableSer, enablePar"); 
  $monitor("%d\t%d\t%d\t%d\t%b\t%b",$time, testNum, codeSer, codePar, enableSer, enablePar); 
end
initial begin 
  #0 
  clk=1'b0; 
  sig=1'b0; 
  testNum=0; 
  testNum=testNum+1; 
  fAct=f_clk/10; 
  repeat (8*m*clk_units) begin 
    #100 sig=~sig; 
  end
  #5 $finish; 
end
always begin 
  #10 
  clk=~clk; 
end
endmodule 