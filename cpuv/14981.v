module instance to compute the frequency 8 times. 
#2753 sig=~sig; 
if( nSig%(2*(m))==0 && nSig>0 ) begin 
	fComputeCounter=fComputeCounter+1; 
	nSig=0; 
end else begin
    nSig=nSig+1; 
end
#5 $finish; 
always begin
  #100 
  clk=~clk; 
end
endmodule 