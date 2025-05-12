module EG_PHY_SDRAM_2M_32( 
  input clk,               
  input ras_n,             
  input cas_n,             
  input we_n,              
  input [10:0] addr,       
  input [1:0] ba,          
  inout [31:0] dq,         
  input cs_n,              
  input dm0,               
  input dm1,               
  input dm2,               
  input dm3,               
  input cke                
);
endmodule                  