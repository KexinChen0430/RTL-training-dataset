module pll_filter_balanced_lookup( 
    input clk, 
    input [6:0] divider, 
    output reg [9:0] value 
    );
    (*rom_style = "block" *) reg [9:0] lookup [0:64]; 
    wire [5:0] addr; 
   initial 
   begin
   end
assign addr = divider - 1; 
always @(posedge clk) 
begin
    value = lookup[addr]; 
end
endmodule 