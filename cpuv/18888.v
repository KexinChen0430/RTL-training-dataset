module's undeclared outputs)
   reg [SZ-1:0]		b; 
   integer 	   i; 
   always @(g) 
     for (i=0; i<SZ; i=i+1) 
       b[i] = ^(g >> i);  
endmodule 