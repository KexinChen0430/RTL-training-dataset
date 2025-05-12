module soc_design_SystemID (
    address,   
    clock,     
    reset_n,   
    readdata   
);
  output [31:0] readdata; 
  input         address;  
  input         clock;    
  input         reset_n;  
  wire   [31:0] readdata; 
  assign readdata = address ? 32'h5965F5AB : 32'h000000FF;
endmodule