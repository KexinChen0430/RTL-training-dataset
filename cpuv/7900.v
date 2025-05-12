module clk_switch
  (
   input            pll_clock,   
   input [1:0]      bpp,         
   input            vga_mode,    
   output           pix_clk,     
   output           pix_clk_vga, 
   output reg       crt_clk      
   );
reg	[1:0]	crt_divider;
reg	[2:0]	crt_counter;
always @* 
	begin
   		casex({vga_mode, bpp}) 
   		3'b1_xx: crt_divider = 2'b00; 
   		3'b0_01: crt_divider = 2'b10; 
   		3'b0_10: crt_divider = 2'b01; 
   		default: crt_divider = 2'b00; 
		endcase
	end
assign pix_clk     = pll_clock;    
assign pix_clk_vga = pll_clock;    
initial begin
    crt_counter = 0; 
end
always @(posedge pll_clock) begin
    crt_counter <= crt_counter + 1; 
    case (crt_divider) 
      0: crt_clk <= 1'b1;              
      1: crt_clk <= ~crt_counter[0];   
      2: crt_clk <= ~|crt_counter[1:0]; 
      3: crt_clk <= ~|crt_counter[2:0]; 
    endcase 
  end
endmodule 