module rom (
    dout, 
    addr  
);
output [7:0] dout;
reg [7:0] dout;
input [6:0] addr;
always @(addr) begin: ROM_READ
    case (addr)
        0: dout = 0;
        1: dout = 8;
        126: dout = 99;
        default: dout = 67;
    endcase
end
endmodule