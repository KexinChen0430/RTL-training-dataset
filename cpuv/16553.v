module coredffr(q, d, purst, S_R, cbit, clk, clkb);
  input S_R;       
  input [1:0] cbit; 
  input clk;       
  input clkb;      
  input d;         
  input purst;     
  output q;        
endmodule