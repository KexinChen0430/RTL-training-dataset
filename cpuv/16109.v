module  sbox8(addr, dout); 
input	[1:6] addr; 
output	[1:4] dout; 
reg	[1:4] dout; 
always @(addr) begin
    case ({addr[1], addr[6], addr[2:5]})	
         0:  dout = 13; 
         1:  dout =  2; 
    endcase
    end
endmodule 