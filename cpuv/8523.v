module S3(
    input [5:0] B,        
    output [3:0] S_B      
);
assign S_B =  
    (B == 0) ? 4'b1010 : 
    (B == 1) ? 4'b1101 : 
    (B == 2) ? 4'b0 :    
    (B == 3) ? 4'b111 :  
    (B == 60) ? 4'b1110 : 
    (B == 61) ? 4'b10 :   
    (B == 62) ? 4'b111 :  
    4'b1100;              
endmodule