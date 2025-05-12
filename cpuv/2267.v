module ColorCorrection
(
    input[ `size_int - 1 : 0 ]R,
    input[ `size_int - 1 : 0 ]G,
    input[ `size_int - 1 : 0 ]B,
    output wire[ `size_int - 1 : 0 ]R_out,
    output wire[ `size_int - 1 : 0 ]G_out,
    output wire[ `size_int - 1 : 0 ]B_out
);
    reg[ `size_int : 0 ]R_int;
    reg[ `size_int : 0 ]G_int;
    reg[ `size_int : 0 ]B_int;
    always@( R or G or B )
    begin
        R_int = (  R * `CC1 - G * `CC2 - B * `CC3 ) >> `ScaleBit;
        G_int = ( -R * `CC4 + G * `CC5 - B * `CC6 ) >> `ScaleBit;
        B_int = (  R * `CC7 - G * `CC8 + B * `CC9 ) >> `ScaleBit;
    end
    assign R_out = ( R_int[ 17 : 16 ] == 2'b00 ) ? R_int : ( R_int[ 17 ] == 1'b1 ) ? `MinThreshold : `MaxThreshold;
    assign G_out = ( G_int[ 17 : 16 ] == 2'b00 ) ? G_int : ( G_int[ 17 ] == 1'b1 ) ? `MinThreshold : `MaxThreshold;
    assign B_out = ( B_int[ 17 : 16 ] == 2'b00 ) ? B_int : ( B_int[ 17 ] == 1'b1 ) ? `MinThreshold : `MaxThreshold;
endmodule