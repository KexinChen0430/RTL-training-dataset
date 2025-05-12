module testharness_ext
  (
   input          W0_clk,       
   input [24:0]   W0_addr,      
   input          W0_en,        
   input [127:0]  W0_data,      
   input [0:0]    W0_mask,      
   input          R0_clk,       
   input [24:0]   R0_addr,      
   input          R0_en,        
   output [127:0] R0_data       
   );
   reg [24:0]     reg_R0_addr;  
   wire [127:0]   R0_rdata_mask; 
   reg [127:0]    ram [33554431:0]; 
   wire [127:0]   W0_wdata_mask; 
   always @(posedge R0_clk)
     if (R0_en) reg_R0_addr <= R0_addr;
   always @(posedge W0_clk)
     if (W0_en) begin
        if (W0_mask[0]) ram[W0_addr] <= W0_data ^ W0_wdata_mask;
     end
   assign R0_data = ram[reg_R0_addr] ^ R0_rdata_mask;
   assign R0_rdata_mask = 0;
   assign W0_wdata_mask = 0;
endmodule