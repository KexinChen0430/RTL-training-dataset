module Test
  (
   input logic              pick1,          
   input logic [13:0] [1:0] data1,          
   input logic [ 3:0] [2:0] [1:0] data2,    
   output logic [15:0] [1:0] datao          
   );
   always_comb datao[13: 0]                 
     = (pick1)                              
       ? {data1}                            
       : {'0, data2};                       
   always_comb datao[15:14] = '0;           
endmodule