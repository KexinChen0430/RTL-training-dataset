module mux3( sel, a, b, c, y ); 
    input [1:0] sel; 
    input  [31:0] a, b, c; 
    output  y; 
    reg [31:0] y; 
    always @(a or b or c or sel) 
    begin
        case (sel) 
            2'b00:y = a; 
            2'b10:y = b; 
            2'b01:y = c; 
        endcase 
    end 
endmodule 