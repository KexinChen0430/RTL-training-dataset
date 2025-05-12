module sub 
`ifdef NANSI  
  ( 
   isub, i_value 
   );
   ifc.out_modport isub;   
   input integer i_value;   
`else 
  ( 
   ifc.out_modport isub, 
   input integer i_value 
   );
`endif 
   always @* begin 
      isub.value = i_value; 
   end 
endmodule 