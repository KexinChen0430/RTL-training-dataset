module  sbox1(addr, dout);
input   [1:6] addr;
output  [1:4] dout;
reg     [1:4] dout;
always @(addr) begin
    case ({addr[1], addr[6], addr[2:5]}) 
         0:  dout =  14;
         1:  dout =   4;
         2:  dout =  13;
         3:  dout =   1;
         4:  dout =   2;
         5:  dout =  15;
         6:  dout =  11;
         7:  dout =   8;
         8:  dout =   3;
         9:  dout =  10;
        10:  dout =   6;
        11:  dout =  12;
        12:  dout =   5;
        13:  dout =   9;
        14:  dout =   0;
        15:  dout =   7;
        16:  dout =   0; 
        17:  dout =  15;
        62:  dout =   6;
        63:  dout =  13;
    endcase
end
endmodule