module sbox6(addr, dout); 
input [1:6] addr; 
output [1:4] dout; 
reg [1:4] dout; 
always @(addr) begin
    case ({addr[1], addr[6], addr[2:5]}) 
         0:  dout = 12;
         1:  dout =  1;
         2:  dout = 10;
         3:  dout = 15;
         4:  dout =  9;
         5:  dout =  2;
         6:  dout =  6;
         7:  dout =  8;
         8:  dout =  0;
         9:  dout = 13;
        10:  dout =  3;
        11:  dout =  4;
        12:  dout = 14;
        13:  dout =  7;
        14:  dout =  5;
        15:  dout = 11;
        63:  dout = 13; 
    endcase
end 
endmodule 