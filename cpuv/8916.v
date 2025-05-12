module reg_ram (clk, we, w_addr, r_addr, integral_addr, d_in, d_out, d_out_int);
    parameter MEM_SIZE = 76800;
    parameter BITS = 17;
    input clk;
    input we;
    input [16:0] w_addr;
    input [BITS-1:0] d_in;
    input [16:0] r_addr;
    input [16:0] integral_addr;
    output reg [BITS-1:0] d_out;
    output reg [BITS-1:0] d_out_int;
    reg [BITS-1:0] ram [MEM_SIZE-1:0]; 
    always @(posedge clk) begin
        if (we)
            ram[w_addr] <= d_in;
        d_out <= ram[r_addr];
        d_out_int <= ram[integral_addr];
    end
endmodule