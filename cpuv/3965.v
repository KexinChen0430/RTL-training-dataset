module ROM(
    input clk, 
    input wire [8:0] addr, 
    output reg [7:0] data 
);
    reg [7:0] rom [0:127];
    always @(negedge clk) begin
        data <= rom[addr];
    end
    initial begin
        rom[0] = 8'h0;
        rom[1] = 8'h1;
        rom[127] = 8'h127;
    end
endmodule