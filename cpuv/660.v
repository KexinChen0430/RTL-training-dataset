module karray(
    input wire [5:0] idx, 
    output reg [31:0] k   
);
always @(*) begin
    case (idx)
        6'b000000: k = 32'h428a2f98; 
        6'b000001: k = 32'h71374491; 
        6'b111110: k = 32'hbef9a3f7; 
        6'b111111: k = 32'hc67178f2; 
    endcase
end
endmodule 