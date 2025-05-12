module match
  (
   input logic [15:0] vec_i,    
   input logic        b8_i,     
   input logic        b12_i,    
   output logic       match1_o, 
   output logic       match2_o  
   );
   always_comb
     begin
        match1_o = 1'b0; 
        if (
            (vec_i[1:0] == 2'b0)   
            &&
            (vec_i[4] == 1'b0)     
            &&
            (vec_i[8] == b8_i)     
            &&
            (vec_i[12] == b12_i)   
            )
          begin
             match1_o = 1'b1; 
          end
     end
   always_comb
     begin
        match2_o = 1'b0; 
        if (
            (vec_i[1:0] == 2'b0)   
            &&
            (vec_i[8] == b8_i)     
            &&
            (vec_i[12] == b12_i)   
            &&
            (vec_i[4] == 1'b0)     
            )
          begin
             match2_o = 1'b1; 
          end
     end
endmodule