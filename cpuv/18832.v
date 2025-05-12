module %m **************************************"); 
#10; 
for(ii=0; ii<(MSB+1); ii=ii+1) 
  ar_reg[ii] <= 3'sd1; 
#10; 
for(ii=0; ii<(MSB+1); ii=ii+1) 
  ar_reg[ii] <= 3'sd0; 
$display("\n\n"); 
end 
endmodule 