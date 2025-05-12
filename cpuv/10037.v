module)
   */
   assign spr_vr2[`OR1K_SPR_VR2_CPUID] = `MOR1KX_CPUID;
   assign spr_vr2[`OR1K_SPR_VR2_VER] = {`MOR1KX_VERSION_MAJOR,
                                        `MOR1KX_VERSION_MINOR,
                                        8'd0};
   assign spr_avr[`OR1K_SPR_AVR_MAJ] = 8'd1;
   assign spr_avr[`OR1K_SPR_AVR_MIN] = 8'd1;
   assign spr_avr[`OR1K_SPR_AVR_REV] = 8'd0;
   assign spr_avr[`OR1K_SPR_AVR_RESERVED] = 0;
   assign spr_dmmucfgr[31:15] = 0;
   assign spr_dmmucfgr[`OR1K_SPR_DMMUFGR_HTR] = 0;
   assign spr_dmmucfgr[`OR1K_SPR_DMMUFGR_TEIRI] = 0;
   assign spr_dmmucfgr[`OR1K_SPR_DMMUFGR_PRI] = 0;
   assign spr_dmmucfgr[`OR1K_SPR_DMMUFGR_CRI] = 0;
   assign spr_dmmucfgr[`OR1K_SPR_DMMUFGR_NAE] = 0;
   assign spr_dmmucfgr[`OR1K_SPR_DMMUFGR_NTS] = (FEATURE_DMMU!="NONE") ?
						OPTION_DMMU_SET_WIDTH : 0;
   assign spr_dmmucfgr[`OR1K_SPR_DMMUFGR_NTW] = (FEATURE_DMMU!="NONE") ?
						OPTION_DMMU_WAYS-1 : 0;
   assign spr_immucfgr[31:15] = 0;
   assign spr_immucfgr[`OR1K_SPR_IMMUFGR_HTR] = 0;
   assign spr_immucfgr[`OR1K_SPR_IMMUFGR_TEIRI] = 0;
   assign spr_immucfgr[`OR1K_SPR_IMMUFGR_PRI] = 0;
   assign spr_immucfgr[`OR1K_SPR_IMMUFGR_CRI] = 0;
   assign spr_immucfgr[`OR1K_SPR_IMMUFGR_NAE] = 0;
   assign spr_immucfgr[`OR1K_SPR_IMMUFGR_NTS] = (FEATURE_IMMU!="NONE") ?
						OPTION_IMMU_SET_WIDTH : 0;
   assign spr_immucfgr[`OR1K_SPR_IMMUFGR_NTW] = (FEATURE_IMMU!="NONE") ?
						OPTION_IMMU_WAYS-1 : 0;
   assign spr_dccfgr[31:15] = 0;
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_CBWBRI] = 0;
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_CBFRI] = (FEATURE_DATACACHE!="NONE");
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_CBLRI] = 0;
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_CBPRI] = 0;
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_CBIRI] = (FEATURE_DATACACHE!="NONE");
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_CCRI] = 0;
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_CWS] = 0;
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_CBS] = (FEATURE_DATACACHE!="NONE") ?
                                             (OPTION_DCACHE_BLOCK_WIDTH == 5 ?
					      1 : 0) :  0;
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_NCS] = (FEATURE_DATACACHE!="NONE") ?
                                             OPTION_DCACHE_SET_WIDTH : 0;
   assign spr_dccfgr[`OR1K_SPR_DCCFGR_NCW] = (FEATURE_DATACACHE!="NONE") ?
                                             (OPTION_DCACHE_WAYS == 1) ? 3'd0 :
                                             (OPTION_DCACHE_WAYS == 2) ? 3'd1 :
                                             (OPTION_DCACHE_WAYS == 4) ? 3'd2 :
                                             (OPTION_DCACHE_WAYS == 8) ? 3'd3 :
                                             (OPTION_DCACHE_WAYS == 16) ? 3'd4 :
                                             (OPTION_DCACHE_WAYS == 32) ? 3'd5 :
                                             3'd0 : 3'd0;
   assign spr_iccfgr[31:13] = 0;
   assign spr_iccfgr[8] = 0;
   assign spr_iccfgr[`OR1K_SPR_ICCFGR_CBLRI] = 0;
   assign spr_iccfgr[`OR1K_SPR_ICCFGR_CBPRI] = 0;
   assign spr_iccfgr[`OR1K_SPR_ICCFGR_CBIRI] = (FEATURE_INSTRUCTIONCACHE!="NONE");
   assign spr_iccfgr[`OR1K_SPR_ICCFGR_CCRI] = 0;
   assign spr_iccfgr[`OR1K_SPR_ICCFGR_CBS] = (FEATURE_INSTRUCTIONCACHE!="NONE") ?
                                             (OPTION_ICACHE_BLOCK_WIDTH == 5 ?
					      1 : 0) :  0;
   assign spr_iccfgr[`OR1K_SPR_ICCFGR_NCS] = (FEATURE_INSTRUCTIONCACHE!="NONE") ?
                                             OPTION_ICACHE_SET_WIDTH : 0;
   assign spr_iccfgr[`OR1K_SPR_ICCFGR_NCW] = (FEATURE_INSTRUCTIONCACHE!="NONE") ?
                                             (OPTION_ICACHE_WAYS == 1) ? 3'd0 :
                                             (OPTION_ICACHE_WAYS == 2) ? 3'd1 :
                                             (OPTION_ICACHE_WAYS == 4) ? 3'd2 :
                                             (OPTION_ICACHE_WAYS == 8) ? 3'd3 :
                                             (OPTION_ICACHE_WAYS == 16) ? 3'd4 :
                                             (OPTION_ICACHE_WAYS == 32) ? 3'd5 :
                                             3'd0 : 3'd0;
   assign spr_dcfgr = 0;
   assign spr_pccfgr = (FEATURE_PERFCOUNTERS!="NONE") ? OPTION_PERFCOUNTERS_NUM : 0;
endmodule