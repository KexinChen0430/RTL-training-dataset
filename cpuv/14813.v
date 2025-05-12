module MulB(
    input wire sysclock,          
    input wire [31:0] inputMulB,  
    output reg [63:0] product     
);
initial begin
    product <= 64'd0;             
end
always @ (posedge sysclock) begin
    product <= (inputMulB * inputMulB); 
end
endmodule 