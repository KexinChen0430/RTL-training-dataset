module t ();
`define DRAM1(bank) mem.mem_bank[bank].dccm.dccm_bank.ram_core
`define DRAM2(bank) mem.mem_bank2[bank].dccm.dccm_bank.ram_core
`define DRAM3(bank) mem.mem_bank3[bank].dccm.dccm_bank.ram_core
`define DRAM4(bank) mem.sub4.mem_bank4[bank].dccm.dccm_bank.ram_core
initial begin
   `DRAM1(0)[3] = 130; 
   `DRAM1(1)[3] = 131; 
   `DRAM2(0)[3] = 230; 
   `DRAM2(1)[3] = 231; 
   `DRAM3(0)[3] = 330; 
   `DRAM3(1)[3] = 331; 
   `DRAM4(0)[3] = 430; 
   `DRAM4(1)[3] = 431; 
   if (`DRAM1(0)[3] !== 130) $stop; 
   if (`DRAM1(1)[3] !== 131) $stop; 
   if (`DRAM2(0)[3] !== 230) $stop; 
   if (`DRAM2(1)[3] !== 231) $stop; 
   if (`DRAM3(0)[3] !== 330) $stop; 
   if (`DRAM3(1)[3] !== 331) $stop; 
   if (`DRAM4(0)[3] !== 430) $stop; 
   if (`DRAM4(1)[3] !== 431) $stop; 
   $write("*-* All Finished *-*\n"); 
   $finish; 
end
eh2_lsu_dccm_mem mem ();
endmodule