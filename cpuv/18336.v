module dffeas (
  output q,          
  input d,           
  input clk,         
  input clrn,        
  input prn,         
  input ena,         
  input asdata,      
  input aload,       
  input sclr,        
  input sload        
);
parameter power_up="dontcare"; 
parameter is_wysiwyg="false";  
reg q;
always @(posedge clk)
  q <= d; 
endmodule 