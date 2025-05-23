module mul_bodec (
    input x,                
    input [15:0] b,         
    output [2:0] b0,        
    output [2:0] b1,        
    output [2:0] b2,        
    output [2:0] b3,        
    output [2:0] b4,        
    output [2:0] b5,        
    output [2:0] b6,        
    output [2:0] b7         
);
assign b0[2] = b[1];       
assign b0[1] = ~((b[1] & b[0] & x) | (~b[1] & ~b[0] & ~x)); 
assign b0[0] = (~b[1] & b[0] & x) | (b[1] & ~b[0] & ~x);    
assign b1[2] = b[3];       
assign b1[1] = ~((b[3] & b[2] & b[1]) | (~b[3] & ~b[2] & ~b[1])); 
assign b1[0] = (~b[3] & b[2] & b[1]) | (b[3] & ~b[2] & ~b[1]);    
assign b2[2] = b[5];       
assign b2[1] = ~((b[5] & b[4] & b[3]) | (~b[5] & ~b[4] & ~b[3])); 
assign b2[0] = (~b[5] & b[4] & b[3]) | (b[5] & ~b[4] & ~b[3]);    
assign b3[2] = b[7];       
assign b3[1] = ~((b[7] & b[6] & b[5]) | (~b[7] & ~b[6] & ~b[5])); 
assign b3[0] = (~b[7] & b[6] & b[5]) | (b[7] & ~b[6] & ~b[5]);    
assign b4[2] = b[9];       
assign b4[1] = ~((b[9] & b[8] & b[7]) | (~b[9] & ~b[8] & ~b[7])); 
assign b4[0] = (~b[9] & b[8] & b[7]) | (b[9] & ~b[8] & ~b[7]);    
assign b5[2] = b[11];      
assign b5[1] = ~((b[11] & b[10] & b[9]) | (~b[11] & ~b[10] & ~b[9])); 
assign b5[0] = (~b[11] & b[10] & b[9]) | (b[11] & ~b[10] & ~b[9]);    
assign b6[2] = b[13];      
assign b6[1] = ~((b[13] & b[12] & b[11]) | (~b[13] & ~b[12] & ~b[11])); 
assign b6[0] = (~b[13] & b[12] & b[11]) | (b[13] & ~b[12] & ~b[11]);    
assign b7[2] = b[15];      
assign b7[1] = ~((b[15] & b[14] & b[13]) | (~b[15] & ~b[14] & ~b[13])); 
assign b7[0] = (~b[15] & b[14] & b[13]) | (b[15] & ~b[14] & ~b[13]);    
endmodule 