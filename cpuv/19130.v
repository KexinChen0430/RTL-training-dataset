module register_pe(
  clk, rst, clk_ena,
  load,
  datain, dforload,
  dataout
);
  input clk, rst, clk_ena;  
  input load;               
  input [`G_WIDTH-1:0] datain, dforload; 
  output [`G_WIDTH-1:0] dataout;         
  reg [`G_WIDTH-1:0] out;                
  always @(posedge clk or posedge rst)   
    begin
    if(rst)                              
       out <= 0;                         
    else if(clk_ena)                     
      if(load)                           
      out <= dforload;                   
      else
	out <= datain;                    
  end
  assign dataout = out;                  
endmodule