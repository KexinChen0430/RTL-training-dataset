module BrzFetch_32_s5_false (
  activate_0r, activate_0a, 
  inp_0r, inp_0a, inp_0d,   
  out_0r, out_0a, out_0d    
);
  input activate_0r;         
  output activate_0a;        
  output inp_0r;             
  input inp_0a;              
  input [31:0] inp_0d;       
  output out_0r;             
  input out_0a;              
  output [31:0] out_0d;      
  assign activate_0a = out_0a; 
  assign out_0r = inp_0a;      
  assign inp_0r = activate_0r; 
  assign out_0d[0] = inp_0d[0];  
  assign out_0d[1] = inp_0d[1];  
  assign out_0d[2] = inp_0d[2];  
  assign out_0d[31] = inp_0d[31]; 
endmodule 