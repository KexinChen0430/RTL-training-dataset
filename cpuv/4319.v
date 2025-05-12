module nibble_to_segments(
    input [3:0] nibble,       
    output wire [7:0] segments 
    );
    reg [7:0] segments_out;
    assign segments = segments_out;
    always begin
        case (nibble)
            4'h0: segments_out = 8'b11111100; 
            4'h1: segments_out = 8'b01100000; 
            4'h2: segments_out = 8'b11011010; 
            4'h3: segments_out = 8'b11110010; 
            4'h4: segments_out = 8'b01100110; 
            4'h5: segments_out = 8'b10110110; 
            4'h6: segments_out = 8'b10111110; 
            4'h7: segments_out = 8'b11100000; 
            4'h8: segments_out = 8'b11111110; 
            4'h9: segments_out = 8'b11110110; 
            4'ha: segments_out = 8'b11101110; 
            4'hb: segments_out = 8'b00111110; 
            4'hc: segments_out = 8'b10011100; 
            4'hd: segments_out = 8'b01111010; 
            4'he: segments_out = 8'b10011110; 
            4'hf: segments_out = 8'b10001110; 
        endcase
    end
endmodule