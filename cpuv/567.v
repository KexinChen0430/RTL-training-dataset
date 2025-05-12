module retimer(
  input clk,    
  input din,    
  input rst_b,  
  output dout   
);
  reg r1_q, r2_q;
  assign dout = r2_q & din;
  always @ ( `CHANGEDGE clk or negedge rst_b )
    if ( !rst_b) 
      { r1_q, r2_q} <= 0; 
    else 
      { r1_q, r2_q} <= {din, r1_q}; 
endmodule