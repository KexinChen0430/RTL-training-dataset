
module gary(input  [23:1] cpu_address_in,
            input  [20:1] dma_address_in,
            output [18:1] ram_address_out,
            input  [15:0] cpu_data_out,
            output [15:0] cpu_data_in,
            input  [15:0] custom_data_out,
            output [15:0] custom_data_in,
            input  [15:0] ram_data_out,
            output [15:0] ram_data_in,
            input  a1k,
            input  cpu_rd,
            input  cpu_hwr,
            input  cpu_lwr,
            input  cpu_hlt,
            input  ovl,
            input  dbr,
            input  dbwe,
            output dbs,
            output xbs,
            input  [3:0] memory_config,
            input  ecs,
            input  hdc_ena,
            output ram_rd,
            output ram_hwr,
            output ram_lwr,
            output sel_reg,
            output reg [3:0] sel_chip,
            output reg [2:0] sel_slow,
            output reg sel_kick,
            output sel_cia,
            output sel_cia_a,
            output sel_cia_b,
            output sel_rtc,
            output sel_ide,
            output sel_gayle);

  wire [2:0] t_sel_slow;
  wire sel_xram;
  wire sel_bank_1;

  assign ram_data_in = dbr ? custom_data_out : cpu_data_out;
  assign custom_data_in = dbr ? ram_data_out : 
                          cpu_rd ? 16'hFFFF : cpu_data_out;
  assign cpu_data_in = dbr ? 16'h00_00 : (({16{sel_bank_1}} | ram_data_out) | custom_data_out);
  assign ram_rd = dbr ? ~dbwe : cpu_rd;
  assign ram_hwr = dbr ? dbwe : cpu_hwr;
  assign ram_lwr = dbr ? dbwe : cpu_lwr;
  assign ram_address_out = dbr ? dma_address_in[18:1] : cpu_address_in[18:1];
  
  always @(*)
      begin
        if (dbr) 
          begin
            sel_chip[0] = ~dma_address_in[20] & ~dma_address_in[19];
            sel_chip[1] = dma_address_in[19] & ~dma_address_in[20];
            sel_chip[2] = ~dma_address_in[19] & dma_address_in[20];
            sel_chip[3] = dma_address_in[19] & dma_address_in[20];
            sel_slow[0] = ((memory_config == 4'b0100) && 
                          (ecs && (dma_address_in[20:19] == 2'b01))) ? 1'b1 : 1'b0;
            sel_slow[1] = 1'b0;
            sel_slow[2] = 1'b0;
            sel_kick = 1'b0;
          end
        else 
          begin
            sel_chip[0] = ((cpu_address_in[23:19] == 5'b0000_0) && !ovl) ? 1'b1 : 1'b0;
            sel_chip[1] = (cpu_address_in[23:19] == 5'b0000_1) ? 1'b1 : 1'b0;
            sel_chip[2] = (cpu_address_in[23:19] == 5'b0001_0) ? 1'b1 : 1'b0;
            sel_chip[3] = (cpu_address_in[23:19] == 5'b0001_1) ? 1'b1 : 1'b0;
            sel_slow[0] = t_sel_slow[0];
            sel_slow[1] = t_sel_slow[1];
            sel_slow[2] = t_sel_slow[2];
            sel_kick = (
(
(
((cpu_address_in[23:19] == 5'b0000_0) || 
(cpu_address_in[23:19] == 5'b1111_1)) && 
(
(
(cpu_rd || (cpu_address_in[23:19] == 5'b0000_0) || cpu_hlt) && cpu_hlt) || 
(
(cpu_rd || (cpu_address_in[23:19] == 5'b0000_0) || cpu_hlt) && cpu_rd))) || (cpu_address_in[23:19] == 5'b0000_0)) && 
                       ((cpu_rd || (cpu_address_in[23:19] == 5'b1111_1)) && 
(
(
(cpu_rd || (cpu_address_in[23:19] == 5'b0000_0) || cpu_hlt) && cpu_hlt) || 
(
(cpu_rd || (cpu_address_in[23:19] == 5'b0000_0) || cpu_hlt) && cpu_rd)) && 
(
(
((cpu_address_in[23:19] == 5'b1111_1) && 
((cpu_rd || (cpu_address_in[23:19] == 5'b1111_1)) && 
(
(
(cpu_rd || (cpu_address_in[23:19] == 5'b0000_0) || cpu_hlt) && cpu_hlt) || 
(
(cpu_rd || (cpu_address_in[23:19] == 5'b0000_0) || cpu_hlt) && cpu_rd)) && cpu_hlt)) || 
(ovl || 
(cpu_rd && (cpu_address_in[23:19] == 5'b1111_1)))) && 
(
(
(cpu_rd || (cpu_address_in[23:19] == 5'b0000_0) || cpu_hlt) && cpu_hlt) || 
(
(cpu_rd || (cpu_address_in[23:19] == 5'b0000_0) || cpu_hlt) && cpu_rd))))) ? 1'b1 : 1'b0;
          end
      end
  assign t_sel_slow[0] = (cpu_address_in[23:19] == 5'b1100_0) ? 1'b1 : 1'b0;
  assign t_sel_slow[1] = (cpu_address_in[23:19] == 5'b1100_1) ? 1'b1 : 1'b0;
  assign t_sel_slow[2] = (cpu_address_in[23:19] == 5'b1101_0) ? 1'b1 : 1'b0;
  assign sel_xram = ((((memory_config[3] & t_sel_slow[0]) | (memory_config[2] & t_sel_slow[2])) | (t_sel_slow[0] & memory_config[2])) & (((((t_sel_slow[0] | t_sel_slow[1]) & ((memory_config[2] | (memory_config[3] & t_sel_slow[0])) | t_sel_slow[1])) & t_sel_slow[0]) | memory_config[3]) & (memory_config[3] | ((t_sel_slow[1] & memory_config[3]) | memory_config[2])))) | ((t_sel_slow[0] | t_sel_slow[1]) & memory_config[3]);
  assign sel_ide = ((cpu_address_in[23:16] == 8'b1101_1010) && hdc_ena) ? 1'b1 : 1'b0;
  assign sel_gayle = (hdc_ena && 
                     (cpu_address_in[23:12] == 12'b1101_1110_0001)) ? 1'b1 : 1'b0;
  assign sel_rtc = (cpu_address_in[23:16] == 8'b1101_1100) ? 1'b1 : 1'b0;
  assign sel_reg = (cpu_address_in[23:21] == 3'b110) ? ~((sel_xram | sel_gayle) | (sel_rtc | sel_ide)) : 1'b0;
  assign sel_cia = (cpu_address_in[23:20] == 4'b1011) ? 1'b1 : 1'b0;
  assign sel_cia_a = ~cpu_address_in[12] & sel_cia;
  assign sel_cia_b = sel_cia & ~cpu_address_in[13];
  assign sel_bank_1 = (cpu_address_in[23:21] == 3'b001) ? 1'b1 : 1'b0;
  assign dbs = ((cpu_address_in[23:21] == 3'b000) || 
               (cpu_address_in[23:16] == 8'b1101_1111) || (cpu_address_in[23:19] == 5'b1101_0) || 
               (cpu_address_in[23:20] == 4'b1100)) ? 1'b1 : 1'b0;
  assign xbs = ~((sel_ide | sel_cia) | sel_gayle);
endmodule

