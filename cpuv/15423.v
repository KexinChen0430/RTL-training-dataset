module xyz
  #(parameter int FOO=1, 
    parameter int BAR=2, 
    parameter logic [5:0] BLUP=3, 
    parameter logic [5:0] ZOT=4, 
    parameter int LDWRDS=5) 
   ( input x1, x2, 
     input int         i1, i2, 
     input logic [5:0] i3, i4, 
     input             i5, 
     output            y); 
endmodule