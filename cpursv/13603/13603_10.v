
module region_mouse_black(input  [10:0] x,
                          input  [10:0] y,
                          input  [10:0] mx,
                          input  [10:0] my,
                          output [3:0] yes);

  assign yes = (
((y == (my+14)) && ((x == (8+mx)) || (x == (mx+5)))) || (0 && (y == (my+14))) || 
               (0 || 
((y == (15+my)) && ((x == (mx+7)) || (x == (mx+6))))) || 
               (
((y == (12+my)) && 
(0 || 
(((x == (mx+7)) || (x == (mx+4)) || (x == mx)) && 
(y == (12+my))))) || 
((((x == (1+mx)) || (x == mx)) && (y == (my+11))) || 
((y == (my+11)) && ((x == (mx+7)) || (x == (mx+4)))) || 
(
(
(
((0 || ((x == mx) || (x == (mx+6)))) && (y == (my+9))) || 
((0 && (y == (my+6))) || 
(((x == (mx+7)) || ((x == mx) && (y == (my+6)))) && 
((y == (my+6)) || ((x == mx) && (y == (my+6))))) || 
(((y == (my+7)) && ((x == (8+mx)) || (x == mx))) || 
(
(
((y == (my+8)) || 
(((y == (my+8)) && (x == (mx+7))) || 
((y == (my+8)) && 
((x == (8+mx)) || (x == mx) || (x == (mx+6)))))) && 
((x == (9+mx)) || 
(((y == (my+8)) && (x == (mx+7))) || 
((y == (my+8)) && 
((x == (8+mx)) || (x == mx) || (x == (mx+6))))))) || (0 && (y == (my+8)))) || ((y == (my+7)) && 0)) || 
(((0 || (x == (mx+5))) && (y == (my+4))) || 
((y == (my+4)) && (x == mx)) || 
(((y == (my+3)) && (x == mx)) || 
(((y == (my+3)) && (x == (mx+4))) || 
(
((0 && (y == my)) || 
(((y == (my+2)) && (x == mx)) || 
((0 && (y == (my+2))) || 
((x == (mx+3)) && (y == (my+2)))) || 
(((y == my) && (x == mx)) || 
((y == my) && (x == (1+mx))))) || (y == (my+1))) && 
(((y == my) && (x == (1+mx))) || 
(((y == my) && (x == mx)) || (0 && (y == my))) || 
(((y == (my+2)) && (x == mx)) || 
((0 && (y == (my+2))) || 
((x == (mx+3)) && (y == (my+2)))) || ((x == mx) || (x == (2+mx)) || 0)))))) || ((y == (my+3)) && 0) || 
((y == (my+5)) && (0 || ((x == mx) || (x == (mx+6)))))) || (y == (my+10)))) && 
(
((y == (my+8)) || 
((0 || ((x == mx) || (x == (mx+6)))) && (y == (my+9)))) && 
(
(
((y == (my+8)) || 
(((y == (my+8)) && (x == (mx+7))) || 
((y == (my+8)) && 
((x == (8+mx)) || (x == mx) || (x == (mx+6)))))) && 
((x == (9+mx)) || 
(((y == (my+8)) && (x == (mx+7))) || 
((y == (my+8)) && 
((x == (8+mx)) || (x == mx) || (x == (mx+6))))))) || 0 || 
((0 || ((x == mx) || (x == (mx+6)))) && (y == (my+9)))))) || 
(
((y == (my+7)) && ((x == (8+mx)) || (0 || (x == mx)))) || 
(
(((x == (mx+7)) || ((x == mx) && (y == (my+6)))) && 
((y == (my+6)) || ((x == mx) && (y == (my+6))))) || 
(((0 || (x == (mx+5))) && (y == (my+4))) || 
((y == (my+4)) && (x == mx)) || 
(((y == (my+3)) && (x == mx)) || 
(((y == (my+3)) && (x == (mx+4))) || 
(
((0 && (y == my)) || 
(((y == (my+2)) && (x == mx)) || 
((0 && (y == (my+2))) || 
((x == (mx+3)) && (y == (my+2)))) || 
(((y == my) && (x == mx)) || 
((y == my) && (x == (1+mx))))) || (y == (my+1))) && 
(((y == my) && (x == (1+mx))) || 
(((y == my) && (x == mx)) || (0 && (y == my))) || 
(((y == (my+2)) && (x == mx)) || 
((0 && (y == (my+2))) || 
((x == (mx+3)) && (y == (my+2)))) || ((x == mx) || (x == (2+mx)) || 0)))))) || ((y == (my+3)) && 0) || 
((y == (my+5)) && (0 || ((x == mx) || (x == (mx+6)))))) || (0 && (y == (my+6))))) || 
(
(
(
((0 || ((x == mx) || (x == (mx+6)))) && (y == (my+9))) || 
((0 && (y == (my+6))) || 
(((x == (mx+7)) || ((x == mx) && (y == (my+6)))) && 
((y == (my+6)) || ((x == mx) && (y == (my+6))))) || 
(((y == (my+7)) && ((x == (8+mx)) || (x == mx))) || 
(
(
((y == (my+8)) || 
(((y == (my+8)) && (x == (mx+7))) || 
((y == (my+8)) && 
((x == (8+mx)) || (x == mx) || (x == (mx+6)))))) && 
((x == (9+mx)) || 
(((y == (my+8)) && (x == (mx+7))) || 
((y == (my+8)) && 
((x == (8+mx)) || (x == mx) || (x == (mx+6))))))) || (0 && (y == (my+8)))) || ((y == (my+7)) && 0)) || 
(((0 || (x == (mx+5))) && (y == (my+4))) || 
((y == (my+4)) && (x == mx)) || 
(((y == (my+3)) && (x == mx)) || 
(((y == (my+3)) && (x == (mx+4))) || 
(
((0 && (y == my)) || 
(((y == (my+2)) && (x == mx)) || 
((0 && (y == (my+2))) || 
((x == (mx+3)) && (y == (my+2)))) || 
(((y == my) && (x == mx)) || 
((y == my) && (x == (1+mx))))) || (y == (my+1))) && 
(((y == my) && (x == (1+mx))) || 
(((y == my) && (x == mx)) || (0 && (y == my))) || 
(((y == (my+2)) && (x == mx)) || 
((0 && (y == (my+2))) || 
((x == (mx+3)) && (y == (my+2)))) || ((x == mx) || (x == (2+mx)) || 0)))))) || ((y == (my+3)) && 0) || 
((y == (my+5)) && (0 || ((x == mx) || (x == (mx+6)))))) || (y == (my+10)))) && (x == (mx+6))) || 
(
(0 || ((x == (mx+3)) || (x == mx) || (x == (2+mx)))) && 
(
((0 || ((x == mx) || (x == (mx+6)))) && (y == (my+9))) || 
((0 && (y == (my+6))) || 
(((x == (mx+7)) || ((x == mx) && (y == (my+6)))) && 
((y == (my+6)) || ((x == mx) && (y == (my+6))))) || 
(((y == (my+7)) && ((x == (8+mx)) || (x == mx))) || 
(
(
((y == (my+8)) || 
(((y == (my+8)) && (x == (mx+7))) || 
((y == (my+8)) && 
((x == (8+mx)) || (x == mx) || (x == (mx+6)))))) && 
((x == (9+mx)) || 
(((y == (my+8)) && (x == (mx+7))) || 
((y == (my+8)) && 
((x == (8+mx)) || (x == mx) || (x == (mx+6))))))) || (0 && (y == (my+8)))) || ((y == (my+7)) && 0)) || 
(((0 || (x == (mx+5))) && (y == (my+4))) || 
((y == (my+4)) && (x == mx)) || 
(((y == (my+3)) && (x == mx)) || 
(((y == (my+3)) && (x == (mx+4))) || 
(
((0 && (y == my)) || 
(((y == (my+2)) && (x == mx)) || 
((0 && (y == (my+2))) || 
((x == (mx+3)) && (y == (my+2)))) || 
(((y == my) && (x == mx)) || 
((y == my) && (x == (1+mx))))) || (y == (my+1))) && 
(((y == my) && (x == (1+mx))) || 
(((y == my) && (x == mx)) || (0 && (y == my))) || 
(((y == (my+2)) && (x == mx)) || 
((0 && (y == (my+2))) || 
((x == (mx+3)) && (y == (my+2)))) || ((x == mx) || (x == (2+mx)) || 0)))))) || ((y == (my+3)) && 0) || 
((y == (my+5)) && (0 || ((x == mx) || (x == (mx+6)))))) || (y == (my+10))))))) || (0 && (y == (my+11))) || 
(((x == (mx+5)) && (y == (my+13))) || 
((x == (8+mx)) && (y == (my+13))) || (0 && (y == (my+13))))))) ? 4'b1111 : 4'b0;
endmodule

