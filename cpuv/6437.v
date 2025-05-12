module ToneReproduction
(
    input[ `size_int - 1 : 0 ]L,          
    input[ `size_int - 1 : 0 ]IN_R,       
    input[ `size_int - 1 : 0 ]IN_G,       
    input[ `size_int - 1 : 0 ]IN_B,       
    output reg[ `size_int - 1 : 0 ]OUT_R, 
    output reg[ `size_int - 1 : 0 ]OUT_G, 
    output reg[ `size_int - 1 : 0 ]OUT_B  
);
always@( L )
begin
    if( L <= `L1x )
    begin
        OUT_R = ( ( IN_R * `a1 ) + `b1 ); 
        OUT_G = ( ( IN_G * `a1 ) + `b1 ); 
        OUT_B = ( ( IN_B * `a1 ) + `b1 ); 
    end
    else if( `L1x < L && L <= `L2x)
    begin
        OUT_R = ( ( IN_R * `a2 ) + `b2 ); 
        OUT_G = ( ( IN_G * `a2 ) + `b2 ); 
        OUT_B = ( ( IN_B * `a2 ) + `b2 ); 
    end
    else if( `L2x < L && L <= `L3x)
    begin
        OUT_R = ( ( IN_R * `a3 ) + `b3 ); 
        OUT_G = ( ( IN_G * `a3 ) + `b3 ); 
        OUT_B = ( ( IN_B * `a3 ) + `b3 ); 
    end
    else
    begin
        OUT_R = ( ( IN_R * `a4 ) + `b4 ); 
        OUT_G = ( ( IN_G * `a4 ) + `b4 ); 
        OUT_B = ( ( IN_B * `a4 ) + `b4 ); 
    end
end
endmodule