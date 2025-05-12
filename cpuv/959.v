module jt51_phrom
(
    input [4:0] addr,  
    input clk,         
    output reg [45:0] ph 
);
    reg [45:0] sinetable[31:0];
    initial
    begin
        sinetable[5'd0 ] = 46'b0001100000100100010001000010101010101001010010;
        sinetable[5'd31] = 46'b1110011011110001111011100111100001110110100111;
    end
    always @ (posedge clk)
    begin
        ph <= sinetable[addr];
    end
endmodule