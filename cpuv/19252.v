module sub1(input [3:0]addr, output logic [7:0] rd_data);
   genvar cannot_split_genvar ;
   logic [15:0] [8:0] cannot_split  ;
   always_comb begin
      logic [8:0] rd_tmp  = cannot_split[addr];
      rd_data = rd_tmp[{3'b0, addr[0]}+:8];
   end
endmodule