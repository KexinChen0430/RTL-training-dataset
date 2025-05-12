module lower 
  (
   ifc isub, 
   input integer i_value 
   );
`ifdef INLINE_C 
`else  
`endif 
   always @* begin 
      isub.value = i_value; 
   end 
endmodule 