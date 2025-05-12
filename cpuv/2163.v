module wave_gen_string(
    input  [5:0] ramp,      
    output reg [15:0] music_o 
);
always@(ramp[5:0])
begin
    case(ramp[5:0])
        0 : music_o = 16'h0;
        1 : music_o = 16'h0;
        2 : music_o = 16'h0;
        3 : music_o = 16'h0;
        4 : music_o = 16'h0;
        5 : music_o = 16'h0;
        6 : music_o = 16'h246;
        7 : music_o = 16'hC36;
        8 : music_o = 16'hCFC;
        62 : music_o = 16'hFFFFF4AF;
        63 : music_o = 16'hFFFFFAA7;
        default : music_o = 0;
    endcase
end
endmodule