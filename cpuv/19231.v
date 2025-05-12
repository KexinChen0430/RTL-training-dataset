module sub0(input [3:0]addr, output logic [7:0] rd_data); 
   logic [7:0] cannot_split0[0:15]  ; 
   logic [7:0] cannot_split1[0:15]  ; 
   always_comb 
      rd_data = cannot_split0[addr]; 
endmodule 