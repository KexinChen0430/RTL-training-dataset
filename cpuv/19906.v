module */ 
   generate 
      if (FEATURE_DMMU!="NONE") begin : dmmu_ctrl 
         assign spr_access_ack[1] = spr_bus_ack_dmmu_i; 
         assign spr_internal_read_dat[1] = spr_bus_dat_dmmu_i; 
      end
      else begin 
         assign spr_access_ack[1] = 0; 
         assign spr_internal_read_dat[1] = 0; 
      end
   endgenerate 
   generate 
      if (FEATURE_INBUILT_CHECKERS != "NONE") begin : execute_checker 
      end
   endgenerate 
endmodule 