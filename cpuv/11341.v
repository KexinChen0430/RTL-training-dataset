module fastmem(
    input 	    CLKCPU, 
    input 	    RESET, 
    input [23:0]     A, 
    inout [7:0] 	    D, 
    input [1:0] 	    SIZ, 
    input 	    AS20, 
    input 	    RW20, 
    input 	    DS20, 
    output reg 	    RAM_MUX, 
    output  	    RAMOE, 
    output reg [3:0] CAS, 
    output reg [1:0] RAS, 
    output [1:0]     RAM_A, 
    output 	    RAM_ACCESS, 
    output 	    Z2_ACCESS, 
    output reg	    WAIT 
);
wire [5:0] zaddr = {A[6:1]}; 
reg configured = 'b0; 
reg shutup		= 'b0; 
reg [7:4] data_out; 
reg [7:5] base_address; 
wire Z2_WRITE = (Z2_ACCESS | RW20); 
wire Z2_READ = (Z2_ACCESS | ~RW20); 
always @(negedge DS20 or negedge RESET) begin
    if (RESET == 1'b0) begin
        configured <= 1'b0; 
        shutup <= 1'b0; 
    end else begin
        if (Z2_WRITE == 1'b0) begin
            case (zaddr)
                'h24: begin
                    base_address[7:5] <= D[7:5]; 
                    configured <= 1'b1; 
                end
                'h26: shutup <= 1'b1; 
            endcase
        end
        case (zaddr)
        endcase
    end
end
wire [3:0] bank;
assign bank[0] = A[23:21] != 3'b001; 
assign bank[1] = A[23:21] != 3'b010; 
assign bank[2] = A[23:21] != 3'b011; 
assign bank[3] = A[23:21] != 3'b100; 
wire [1:0] chip_ras = {&bank[3:2], &bank[1:0]};
wire chip_selected = &chip_ras[1:0] | ~configured;
wire [3:0] casint;
always @(posedge CLKCPU, posedge AS20) begin
end
always @(negedge CLKCPU) begin
end
assign D = Z2_READ ? 8'bzzzzzzzz : {data_out,4'bzzzz};
assign RAM_ACCESS = (AS20 | chip_selected);
assign Z2_ACCESS = ({A[23:16]} != {8'hE8}) | AS20 | DS20 | configured | shutup;
assign ROMOE = 1'b0;
endmodule