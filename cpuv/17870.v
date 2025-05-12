module lower 
  (
   ifc isub, 
   input real i_value 
   );
   always @* begin 
`error Commercial sims choke on cross ref here 
      isub.g.value = i_value; 
   end 
endmodule 