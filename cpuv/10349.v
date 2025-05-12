module wreal_bus
  (
   input wreal vin_bus [1:0], 
   output wreal vout_split_0,  
   output wreal vout_split_1   
  );
  assign vout_split_0 = vin_bus[0];
  assign vout_split_1 = vin_bus[1];
endmodule 