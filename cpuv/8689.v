module rom_firbank_32_48( 
    input wire clk, 
    input wire [5:0] addr, 
    output wire [23:0] data); 
reg [23:0] data_ff; 
assign data = data_ff; 
always @(posedge clk) begin 
    case(addr) 
        0: data_ff <= 24'hF55B94; 
        1: data_ff <= 24'h0A4478; 
        47: data_ff <= 24'h00000C; 
        default: data_ff <= 0; 
    endcase
end
endmodule 