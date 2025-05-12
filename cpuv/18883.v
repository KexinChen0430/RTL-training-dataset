module testMod 
   (input wire [2:0] data_i); 
   typedef logic [63:0]    time_t; 
   time_t [2:0] last_transition; 
   genvar b; 
   generate 
      for (b = 0; b <= 2; b++) begin : gen_trans 
         always_ff @(posedge data_i[b] or negedge data_i[b]) begin 
            last_transition[b] <= $time; 
         end 
      end 
   endgenerate 
endmodule 