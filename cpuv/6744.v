module rominfr (clk, en, addr, data); 
    input       clk; 
    input       en; 
    input [4:0] addr; 
    output reg [3:0] data; 
    always @(posedge clk) 
        begin
            if (en) 
                case(addr) 
                    4’b0000: data <= 4’b0010; 
                    4’b0001: data <= 4’b0010; 
                    4’b0010: data <= 4’b1110; 
                    4’b0011: data <= 4’b0010; 
                    4’b0100: data <= 4’b0100; 
                    4’b0101: data <= 4’b1010; 
                    4’b0110: data <= 4’b1100; 
                    4’b0111: data <= 4’b0000; 
                    4’b1000: data <= 4’b1010; 
                    4’b1001: data <= 4’b0010; 
                    4’b1010: data <= 4’b1110; 
                    4’b1011: data <= 4’b0010; 
                    4’b1100: data <= 4’b0100; 
                    4’b1101: data <= 4’b1010; 
                    4’b1110: data <= 4’b1100; 
                    4’b1111: data <= 4’b0000; 
                    default: data <= 4’bXXXX; 
                endcase
        end
endmodule 