module  sbox2(addr, dout); 
input	[1:6] addr; 
output	[1:4] dout; 
reg	[1:4] dout; 
always @(addr) begin
    case ({addr[1], addr[6], addr[2:5]})	
         0:  dout = 15; 
         1:  dout =  1; 
         2:  dout =  8; 
         3:  dout = 14; 
         63:  dout =  9; 
    endcase 
    end 
endmodule 