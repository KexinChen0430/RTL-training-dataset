module swap 
  (input wreal in0, in1, 
   output wreal out0, out1); 
   wreal tmp[0:1] ; 
   assign tmp[0] = in0; 
   assign tmp[1] = in1; 
   assign out0 = tmp[1]; 
   assign out1 = tmp[0]; 
endmodule 