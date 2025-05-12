module Test (   
   o1, o2,                  
   in                       
   );
   input [127:0] in;        
   output logic [127:0] o1; 
   output logic [127:0] o2; 
   always_comb begin: b_test 
      logic [127:0] tmpp;   
      logic [127:0] tmp;    
      tmp  = '0;            
      tmpp = '0;            
      tmp[63:0]  = in[63:0]; 
      tmpp[63:0] = in[63:0]; 
      tmpp[63:0] = {tmp[0+:32], tmp[32+:32]}; 
      tmp[63:0]  = {tmp[0+:32], tmp[32+:32]}; 
      o1 = tmp;              
      o2 = tmpp;             
   end
endmodule