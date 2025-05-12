module sub
  #(parameter MODE = 0) 
   (
    ifc isub,           
    input integer i_value 
   );
   generate
      always_comb isub.i = i_value; 
   endgenerate 
endmodule 