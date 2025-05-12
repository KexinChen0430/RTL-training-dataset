module @entity.txt@
  #(
    parameter WORD_SIZE=16,
    parameter FALL_EDGE=0, 
    parameter ADDR_W=13    
   )
   (
    input  clk_i,
    input  [ADDR_W-1:0] addr_i,
    output [WORD_SIZE-1:0] data_o,
    input  we_i,
    input  [WORD_SIZE-1:0] data_i
   );
localparam ROM_SIZE=2**ADDR_W;
reg [ADDR_W-1:0]    addr_r;
reg [WORD_SIZE-1:0] rom[0:ROM_SIZE-1];
initial begin
@rom.dat@
end
generate
if (!FALL_EDGE)
   begin : use_rising_edge
   always @(posedge clk_i)
   begin : do_rom
     addr_r <= addr_i;
     if (we_i)
        rom[addr_i] <= data_i;
   end 
   end 
else
   begin : use_falling_edge
   always @(negedge clk_i)
   begin : do_rom
     addr_r <= addr_i;
     if (we_i)
        rom[addr_i] <= data_i;
   end 
   end 
endgenerate
assign data_o=rom[addr_r];
endmodule