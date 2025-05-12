module dummy_counter (data, clock, clk_en, cnt_en, aset, sload, q);
input [31:2] data; 
input clock; 
input clk_en; 
input cnt_en; 
input aset; 
input sload; 
output [`PC_WIDTH-1:0] q; 
reg [`PC_WIDTH-1:0] q; 
wire [2:0] sload_cnten_aset;
assign sload_cnten_aset [0] = sload; 
assign sload_cnten_aset [1] = cnt_en; 
assign sload_cnten_aset [2] = aset; 
always @ (posedge clock)
begin
    case (sload_cnten_aset)
        3'b000: q <= q; 
        3'b011: q <= q; 
        3'b110: q <= q; 
        3'b111: q <= q; 
        3'b101: q <= q; 
        3'b100: q <= data; 
        3'b010: 
            begin
                if (clk_en)
                    q <= q + 1; 
                else
                    q <= q; 
            end
        3'b001: q <= 29'b00000000000000000000000000000; 
        default: q <= q; 
    endcase
end
endmodule 