module mem_0_ext(
  input W0_clk,             
  input [8:0] W0_addr,      
  input W0_en,              
  input [63:0] W0_data,     
  input [7:0] W0_mask,      
  input R0_clk,             
  input [8:0] R0_addr,      
  input R0_en,              
  output [63:0] R0_data     
);
  reg [8:0] reg_R0_addr;
  reg [63:0] ram [511:0];
  `ifdef RANDOMIZE
    integer initvar;        
    initial begin           
      #0.002 begin end      
      for (initvar = 0; initvar < 512; initvar = initvar+1) 
        ram[initvar] = {2 {$random}}; 
      reg_R0_addr = {1 {$random}};    
    end
  `endif
  integer i;                
  always @(posedge R0_clk)
    if (R0_en) reg_R0_addr <= R0_addr; 
  always @(posedge W0_clk)
    if (W0_en) begin        
      if (W0_mask[0]) ram[W0_addr][7:0] <= W0_data[7:0];
      if (W0_mask[1]) ram[W0_addr][15:8] <= W0_data[15:8];
      if (W0_mask[2]) ram[W0_addr][23:16] <= W0_data[23:16];
      if (W0_mask[3]) ram[W0_addr][31:24] <= W0_data[31:24];
      if (W0_mask[4]) ram[W0_addr][39:32] <= W0_data[39:32];
      if (W0_mask[5]) ram[W0_addr][47:40] <= W0_data[47:40];
      if (W0_mask[6]) ram[W0_addr][55:48] <= W0_data[55:48];
      if (W0_mask[7]) ram[W0_addr][63:56] <= W0_data[63:56];
    end
  assign R0_data = ram[reg_R0_addr];
endmodule 