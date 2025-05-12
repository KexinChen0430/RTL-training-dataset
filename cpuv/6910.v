module 
generate 
if (FEATURE_DMMU!="NONE") begin : dmmu_ctrl 
   assign spr_access_ack[`OR1K_SPR_DMMU_BASE] = spr_bus_ack_dmmu_i & 
                                                spr_access[`OR1K_SPR_DMMU_BASE];
   assign spr_internal_read_dat[`OR1K_SPR_DMMU_BASE] = 
     spr_bus_dat_dmmu_i &
     {OPTION_OPERAND_WIDTH{spr_access[`OR1K_SPR_DMMU_BASE]}};
end else begin 
   assign spr_access_ack[`OR1K_SPR_DMMU_BASE] = 0; 
   assign spr_internal_read_dat[`OR1K_SPR_DMMU_BASE] = 0; 
end
endgenerate 
generate 
if (FEATURE_IMMU!="NONE") begin : immu_ctrl 
   assign spr_access_ack[`OR1K_SPR_IMMU_BASE] = spr_bus_ack_immu_i & 
                                                spr_access[`OR1K_SPR_IMMU_BASE];
   assign spr_internal_read_dat[`OR1K_SPR_IMMU_BASE] = 
     spr_bus_dat_immu_i &
     {OPTION_OPERAND_WIDTH{spr_access[`OR1K_SPR_IMMU_BASE]}};
end else begin 
   assign spr_access_ack[`OR1K_SPR_IMMU_BASE] = 0; 
   assign spr_internal_read_dat[`OR1K_SPR_IMMU_BASE] = 0; 
end
endgenerate 
generate 
if (FEATURE_DATACACHE!="NONE") begin : datacache_ctrl 
   assign spr_access_ack[`OR1K_SPR_DC_BASE] = spr_bus_ack_dc_i & 
                                              spr_access[`OR1K_SPR_DC_BASE];
   assign spr_internal_read_dat[`OR1K_SPR_DC_BASE] = 
     spr_bus_dat_dc_i & {OPTION_OPERAND_WIDTH{spr_access[`OR1K_SPR_DC_BASE]}};
end else begin 
   assign spr_access_ack[`OR1K_SPR_DC_BASE] = 0; 
   assign spr_internal_read_dat[`OR1K_SPR_DC_BASE] = 0; 
end
endgenerate 
generate 
if (FEATURE_INSTRUCTIONCACHE!="NONE") begin : instructioncache_ctrl 
   assign spr_access_ack[`OR1K_SPR_IC_BASE] = spr_bus_ack_ic_i & 
                                              spr_access[`OR1K_SPR_IC_BASE];
   assign spr_internal_read_dat[`OR1K_SPR_IC_BASE] = 
     spr_bus_dat_ic_i & {OPTION_OPERAND_WIDTH{spr_access[`OR1K_SPR_IC_BASE]}};
end else begin 
   assign spr_access_ack[`OR1K_SPR_IC_BASE] = 0; 
   assign spr_internal_read_dat[`OR1K_SPR_IC_BASE] = 0; 
end
endgenerate 
generate 
if (FEATURE_MAC!="NONE") begin : mac_ctrl 
   assign spr_access_ack[`OR1K_SPR_MAC_BASE] = spr_bus_ack_mac_i & 
                                               spr_access[`OR1K_SPR_MAC_BASE];
   assign spr_internal_read_dat[`OR1K_SPR_MAC_BASE] = 
      spr_bus_dat_mac_i &
      {OPTION_OPERAND_WIDTH{spr_access[`OR1K_SPR_MAC_BASE]}};
end else begin 
   assign spr_access_ack[`OR1K_SPR_MAC_BASE] = 0; 
   assign spr_internal_read_dat[`OR1K_SPR_MAC_BASE] = 0; 
end
endgenerate 
generate 
if (FEATURE_PERFCOUNTERS!="NONE") begin : perfcounters_ctrl 
   assign spr_access_ack[`OR1K_SPR_PC_BASE] = spr_bus_ack_pcu_i & 
                                              spr_access[`OR1K_SPR_PC_BASE];
   assign spr_internal_read_dat[`OR1K_SPR_PC_BASE] = 
     spr_bus_dat_pcu_i & {OPTION_OPERAND_WIDTH{spr_access[`OR1K_SPR_PC_BASE]}};
end else begin 
   assign spr_access_ack[`OR1K_SPR_PC_BASE] = 0; 
   assign spr_internal_read_dat[`OR1K_SPR_PC_BASE] = 0; 
end
endgenerate 
generate 
if (FEATURE_PMU!="NONE") begin : pmu_ctrl 
   assign spr_access_ack[`OR1K_SPR_PM_BASE] = spr_bus_ack_pmu_i & 
                                              spr_access[`OR1K_SPR_PM_BASE];
   assign spr_internal_read_dat[`OR1K_SPR_PM_BASE] = 
     spr_bus_dat_pmu_i & {OPTION_OPERAND_WIDTH{spr_access[`OR1K_SPR_PM_BASE]}};
end else begin 
   assign spr_access_ack[`OR1K_SPR_PM_BASE] = 0; 
   assign spr_internal_read_dat[`OR1K_SPR_PM_BASE] = 0; 
end
endgenerate 
generate 
if (FEATURE_FPU!="NONE") begin : fpu_ctrl 
   assign spr_access_ack[`OR1K_SPR_FPU_BASE] = spr_bus_ack_fpu_i; 
   assign spr_internal_read_dat[`OR1K_SPR_FPU_BASE] = 
     spr_bus_dat_fpu_i &
     {OPTION_OPERAND_WIDTH{spr_access[`OR1K_SPR_FPU_BASE]}};
end else begin 
   assign spr_access_ack[`OR1K_SPR_FPU_BASE] = 0; 
   assign spr_internal_read_dat[`OR1K_SPR_FPU_BASE] = 0; 
end
endgenerate 
endmodule 