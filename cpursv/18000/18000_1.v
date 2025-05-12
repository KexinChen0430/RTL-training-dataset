
module t();

  
  initial  
  begin
    mem.mem_0[0].dccm.dccm_0.ram_core[3] = 130;
    mem.mem_1[1].dccm.dccm_1.ram_core[3] = 131;
    mem.mem_02[0].dccm.dccm_0.ram_core[3] = 230;
    mem.mem_12[1].dccm.dccm_1.ram_core[3] = 231;
    mem.mem_03[0].dccm.dccm_0.ram_core[3] = 330;
    mem.mem_13[1].dccm.dccm_1.ram_core[3] = 331;
    mem.sub4.mem_04[0].dccm.dccm_0.ram_core[3] = 430;
    mem.sub4.mem_14[1].dccm.dccm_1.ram_core[3] = 431;
    if (mem.mem_0[0].dccm.dccm_0.ram_core[3] !== 130) 
      $stop;
      
    if (mem.mem_1[1].dccm.dccm_1.ram_core[3] !== 131) 
      $stop;
      
    if (mem.mem_02[0].dccm.dccm_0.ram_core[3] !== 230) 
      $stop;
      
    if (mem.mem_12[1].dccm.dccm_1.ram_core[3] !== 231) 
      $stop;
      
    if (mem.mem_03[0].dccm.dccm_0.ram_core[3] !== 330) 
      $stop;
      
    if (mem.mem_13[1].dccm.dccm_1.ram_core[3] !== 331) 
      $stop;
      
    if (mem.sub4.mem_04[0].dccm.dccm_0.ram_core[3] !== 430) 
      $stop;
      
    if (mem.sub4.mem_14[1].dccm.dccm_1.ram_core[3] !== 431) 
      $stop;
      
    $write("*-* All Finished *-*\n");
    $finish;
  end
  eh2_lsu_dccm_mem mem();
endmodule

