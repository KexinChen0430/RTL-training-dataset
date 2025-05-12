module sel_bhrfix(
    input wire [4:0] sel,                 
    input wire [`GSH_BHR_LEN-1:0] bhr0,   
    input wire [`GSH_BHR_LEN-1:0] bhr1,   
    input wire [`GSH_BHR_LEN-1:0] bhr2,   
    input wire [`GSH_BHR_LEN-1:0] bhr3,   
    input wire [`GSH_BHR_LEN-1:0] bhr4,   
    output reg [`GSH_BHR_LEN-1:0] out     
);
always @ (*) begin
    out = 0;                              
    case (sel)                            
        5'b00001 : out = bhr0;            
        5'b00010 : out = bhr1;            
        5'b00100 : out = bhr2;            
        5'b01000 : out = bhr3;            
        5'b10000 : out = bhr4;            
        default : out = 0;                
    endcase 
end
endmodule 