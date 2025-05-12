module toyblockram (input         clk, 
                    input [31:0]      addr_a, 
                    output reg [31:0] data_a, 
                    input [31:0]      datain_a, 
                    input             wr_a, 
                    input [31:0]      addr_b, 
                    output reg [31:0] data_b 
                    );
   parameter RAM_DEPTH = `RAM_DEPTH; 
   (* RAM_STYLE="BLOCK" *) 
   reg [31:0] mem [0:RAM_DEPTH-1]; 
   always @(posedge clk) 
     begin
        if (wr_a) begin 
           mem[addr_a] <= datain_a; 
           data_a <= datain_a; 
        end else data_a <= mem[addr_a]; 
        data_b <= mem[addr_b]; 
     end
endmodule