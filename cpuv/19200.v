module register_pe_new(
  clk,        
  rst,        
  clk_ena,    
  load,       
  init,       
  datain,     
  initdata,   
  dataout     
);
  input clk, rst, clk_ena; 
  input load, init; 
  input [`G_WIDTH-1:0] datain, initdata; 
  output [`G_WIDTH-1:0] dataout; 
  reg [`G_WIDTH-1:0] out; 
  always @(posedge clk)
    begin
      if(rst) 
        out <= 'b0; 
      else if(clk_ena) 
        if(init) 
          out <= initdata; 
        else if(load) 
          out <= datain; 
    end
  assign dataout = out; 
endmodule