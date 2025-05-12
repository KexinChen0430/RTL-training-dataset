
module DmaController(input  clk,
                     input  ce,
                     input  reset,
                     input  odd_cycle,
                     input  sprite_trigger,
                     input  dmc_trigger,
                     input  cpu_read,
                     input  [7:0] data_from_cpu,
                     input  [7:0] data_from_ram,
                     input  [15:0] dmc_dma_addr,
                     output [15:0] aout,
                     output aout_enable,
                     output read,
                     output [7:0] data_to_ram,
                     output dmc_ack,
                     output pause_cpu);

  reg  dmc_state;
  reg  [1:0] spr_state;
  reg  [7:0] sprite_dma_lastval;
  reg  [15:0] sprite_dma_addr;
  wire [8:0]  new_sprite_dma_addr = sprite_dma_addr[7:0]+8'h01;

  
  always @(posedge clk)
      if (reset) 
        begin
          dmc_state <= 0;
          spr_state <= 0;
          sprite_dma_lastval <= 0;
          sprite_dma_addr <= 0;
        end
      else if (ce) 
        begin
          if (!odd_cycle && 
              ((dmc_trigger && cpu_read) || spr_state[0]) && (dmc_trigger && cpu_read) && (dmc_state == 0)) dmc_state <= 1;
            
          if (!odd_cycle && (dmc_state == 1)) dmc_state <= 0;
            
          if (sprite_trigger) 
            begin
              sprite_dma_addr <= {data_from_cpu,8'h00};
              spr_state <= 1;
            end
            
          if ((spr_state == 1) && odd_cycle && cpu_read) spr_state <= 3;
            
          if (!odd_cycle && (dmc_state == 1) && spr_state[1]) spr_state <= 1;
            
          if (spr_state[1] && odd_cycle) sprite_dma_addr[7:0] <= new_sprite_dma_addr[7:0];
            
          if (spr_state[1] && new_sprite_dma_addr[8] && odd_cycle) spr_state <= 0;
            
          if (spr_state[1]) sprite_dma_lastval <= data_from_ram;
            
        end
        
  assign pause_cpu = ((dmc_trigger && cpu_read) || spr_state[0]) && 
                     cpu_read;
  assign dmc_ack = !odd_cycle && (dmc_state == 1);
  assign aout_enable = spr_state[1] || dmc_ack;
  assign read = !odd_cycle;
  assign data_to_ram = sprite_dma_lastval;
  assign aout = dmc_ack ? dmc_dma_addr : 
                !odd_cycle ? sprite_dma_addr : 16'h2004;
endmodule

