module ram0 #(
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 8,
    parameter MAX_ADDRESS = 1023
) (
    input wrclk,
    input [DATA_WIDTH-1:0] di,
    input wren,
    input [ADDR_WIDTH-1:0] wraddr,
    input rdclk,
    input rden,
    input [ADDR_WIDTH-1:0] rdaddr,
    output reg [DATA_WIDTH-1:0] do
);
    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] ram[0:MAX_ADDRESS];
    always @ (posedge wrclk) begin
        if (wren == 1) begin
            ram[wraddr] <= di;
        end
    end
    always @ (posedge rdclk) begin
        if (rden == 1) begin
            do <= ram[rdaddr];
        end
    end
endmodule