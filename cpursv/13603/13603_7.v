
module region_mouse_black(input  [10:0] x,
                          input  [10:0] y,
                          input  [10:0] mx,
                          input  [10:0] my,
                          output [3:0] yes);

  assign yes = (
((x == (8+mx)) || ((x == (mx+5)) || 0) || 
(
(
((y == (9+my)) || 
(((x == (8+mx)) && (y == (my+7))) || 
((y == (my+7)) && (x == mx)) || ((y == (my+7)) && 0) || 
((y == (my+8)) && 
(0 || 
((x == (mx+7)) || ((x == mx) || (x == (mx+6))) || 
((x == (mx+9)) || (x == (8+mx))))))) || 
(
(
(
((0 || ((x == (mx+7)) || (x == mx))) && (y == (6+my))) || 
(((y == (5+my)) && (x == mx)) || 
(((x == (mx+6)) && (y == (5+my))) || 
((y == (5+my)) && 0)))) && 
(
(
(
(
((y == (4+my)) || 
(0 || 
(
(
((y == my) || 
(((x == (mx+3)) && (y == ((my+1)+1))) || 
((0 && (y == ((my+1)+1))) || 
((y == ((my+1)+1)) && (x == mx))))) && 
(((x == (mx+3)) && (y == ((my+1)+1))) || 
((0 && (y == ((my+1)+1))) || 
((y == ((my+1)+1)) && (x == mx))) || ((x == mx) || ((x == (mx+1)) || 0)))) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || ((x == (mx+4)) || (x == mx)))) && 
((y == (4+my)) || 
(
(
(
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1)))) || (y == my) || (y == ((my+1)+1))) && 
((x == (mx+1)) || (x == mx) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1)))) || 0 || (y == ((my+1)+1))) && 
((x == (mx+3)) || (x == mx) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))))) || (y == (3+my)) || (0 && (y == ((my+1)+1)))))) || 
((0 || ((x == (mx+7)) || (x == mx))) && (y == (6+my)))) && 
(
((0 || ((x == (mx+7)) || (x == mx))) && (y == (6+my))) || 
((x == (mx+5)) || (x == mx) || 
((0 && (y == ((my+1)+1))) || 
(
(((0 && (y == (3+my))) || (y == (3+my))) && 
((0 && (y == (3+my))) || ((x == (mx+4)) || (x == mx)))) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || 
(
((x == (mx+3)) || ((y == ((my+1)+1)) && (x == mx))) && 
(((y == ((my+1)+1)) && (x == mx)) || (y == ((my+1)+1))))) || 0)))) || (y == (my+7)) || 
(((y == (5+my)) && (x == mx)) || 
(((x == (mx+6)) && (y == (5+my))) || 
((y == (5+my)) && 0))))) || 
(
(
((y == (4+my)) || 
(0 || 
(
(
((y == my) || 
(((x == (mx+3)) && (y == ((my+1)+1))) || 
((0 && (y == ((my+1)+1))) || 
((y == ((my+1)+1)) && (x == mx))))) && 
(((x == (mx+3)) && (y == ((my+1)+1))) || 
((0 && (y == ((my+1)+1))) || 
((y == ((my+1)+1)) && (x == mx))) || ((x == mx) || ((x == (mx+1)) || 0)))) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || ((x == (mx+4)) || (x == mx)))) && 
((y == (4+my)) || 
(
(
(
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1)))) || (y == my) || (y == ((my+1)+1))) && 
((x == (mx+1)) || (x == mx) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1)))) || 0 || (y == ((my+1)+1))) && 
((x == (mx+3)) || (x == mx) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))))) || (y == (3+my)) || (0 && (y == ((my+1)+1))))) && ((x == mx) || 0 || (x == (mx+5)))) || 
((0 && (y == ((my+1)+1))) || 
(
(((0 && (y == (3+my))) || (y == (3+my))) && 
((0 && (y == (3+my))) || ((x == (mx+4)) || (x == mx)))) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || 
(
((x == (mx+3)) || ((y == ((my+1)+1)) && (x == mx))) && 
(((y == ((my+1)+1)) && (x == mx)) || (y == ((my+1)+1))))))))) && 
(((y == (my+8)) && 0) || 
((0 && (y == ((my+1)+1))) || 
(
(((0 && (y == (3+my))) || (y == (3+my))) && 
((0 && (y == (3+my))) || ((x == (mx+4)) || (x == mx)))) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || 
(
((x == (mx+3)) || ((y == ((my+1)+1)) && (x == mx))) && 
(((y == ((my+1)+1)) && (x == mx)) || (y == ((my+1)+1))))) || 
(
(
(((y == (5+my)) && (x == mx)) || 
(((x == (mx+6)) && (y == (5+my))) || 
((y == (5+my)) && 0)) || 
(0 || ((y == (4+my)) && ((x == (mx+5)) || (x == mx))))) && 
((y == (4+my)) || 
(((y == (5+my)) && (x == mx)) || 
(((x == (mx+6)) && (y == (5+my))) || 
((y == (5+my)) && 0))))) || 
(((x == (8+mx)) && (y == (my+7))) || 
((y == (my+7)) && (x == mx)) || ((y == (my+7)) && 0) || 
((0 || ((x == (mx+7)) || (x == mx))) && (y == (6+my))))) || 
(((x == (mx+9)) && (y == (my+8))) || 
((y == (my+8)) && 
((x == (mx+7)) || ((x == mx) || (x == (mx+6))) || 
(x == (8+mx))))) || ((x == mx) || ((x == (mx+6)) || 0))))) || 
(
((((y == (my+10)) && 0) || (y == (my+10))) && 
(((y == (my+10)) && 0) || 
((x == (mx+6)) || 
((x == (mx+3)) || (x == mx) || (x == ((mx+1)+1)))))) || 
(
(0 || 
(((y == (my+11)) && ((x == (mx+1)) || (x == mx))) || 
((y == (my+11)) && ((x == (mx+4)) || (x == (mx+7)))))) && (y == (my+11))))) || 
(
((x == (mx+4)) || (x == mx) || (x == (mx+7)) || 
(0 && (y == (12+my)))) && ((y == (12+my)) || (0 && (y == (12+my))))) || 
(0 || 
(((y == (my+15)) && 0) || 
((y == (my+15)) && ((x == (mx+6)) || (x == (mx+7))))))) && 
               ((y == (14+my)) || 
(
((((y == (my+10)) && 0) || (y == (my+10))) && 
(((y == (my+10)) && 0) || 
((x == (mx+6)) || 
((x == (mx+3)) || (x == mx) || (x == ((mx+1)+1)))))) || 
(
(
((y == (9+my)) || 
(((x == (8+mx)) && (y == (my+7))) || 
((y == (my+7)) && (x == mx)) || ((y == (my+7)) && 0) || 
((y == (my+8)) && 
(0 || 
((x == (mx+7)) || ((x == mx) || (x == (mx+6))) || 
((x == (mx+9)) || (x == (8+mx))))))) || 
(
(
(
((0 || ((x == (mx+7)) || (x == mx))) && (y == (6+my))) || 
(((y == (5+my)) && (x == mx)) || 
(((x == (mx+6)) && (y == (5+my))) || 
((y == (5+my)) && 0)))) && 
(
(
(
(
((y == (4+my)) || 
(0 || 
(
(
((y == my) || 
(((x == (mx+3)) && (y == ((my+1)+1))) || 
((0 && (y == ((my+1)+1))) || 
((y == ((my+1)+1)) && (x == mx))))) && 
(((x == (mx+3)) && (y == ((my+1)+1))) || 
((0 && (y == ((my+1)+1))) || 
((y == ((my+1)+1)) && (x == mx))) || ((x == mx) || ((x == (mx+1)) || 0)))) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || ((x == (mx+4)) || (x == mx)))) && 
((y == (4+my)) || 
(
(
(
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1)))) || (y == my) || (y == ((my+1)+1))) && 
((x == (mx+1)) || (x == mx) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1)))) || 0 || (y == ((my+1)+1))) && 
((x == (mx+3)) || (x == mx) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))))) || (y == (3+my)) || (0 && (y == ((my+1)+1)))))) || 
((0 || ((x == (mx+7)) || (x == mx))) && (y == (6+my)))) && 
(
((0 || ((x == (mx+7)) || (x == mx))) && (y == (6+my))) || 
((x == (mx+5)) || (x == mx) || 
((0 && (y == ((my+1)+1))) || 
(
(((0 && (y == (3+my))) || (y == (3+my))) && 
((0 && (y == (3+my))) || ((x == (mx+4)) || (x == mx)))) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || 
(
((x == (mx+3)) || ((y == ((my+1)+1)) && (x == mx))) && 
(((y == ((my+1)+1)) && (x == mx)) || (y == ((my+1)+1))))) || 0)))) || (y == (my+7)) || 
(((y == (5+my)) && (x == mx)) || 
(((x == (mx+6)) && (y == (5+my))) || 
((y == (5+my)) && 0))))) || 
(
(
((y == (4+my)) || 
(0 || 
(
(
((y == my) || 
(((x == (mx+3)) && (y == ((my+1)+1))) || 
((0 && (y == ((my+1)+1))) || 
((y == ((my+1)+1)) && (x == mx))))) && 
(((x == (mx+3)) && (y == ((my+1)+1))) || 
((0 && (y == ((my+1)+1))) || 
((y == ((my+1)+1)) && (x == mx))) || ((x == mx) || ((x == (mx+1)) || 0)))) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || ((x == (mx+4)) || (x == mx)))) && 
((y == (4+my)) || 
(
(
(
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1)))) || (y == my) || (y == ((my+1)+1))) && 
((x == (mx+1)) || (x == mx) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1)))) || 0 || (y == ((my+1)+1))) && 
((x == (mx+3)) || (x == mx) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))))) || (y == (3+my)) || (0 && (y == ((my+1)+1))))) && ((x == mx) || 0 || (x == (mx+5)))) || 
((0 && (y == ((my+1)+1))) || 
(
(((0 && (y == (3+my))) || (y == (3+my))) && 
((0 && (y == (3+my))) || ((x == (mx+4)) || (x == mx)))) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || 
(
((x == (mx+3)) || ((y == ((my+1)+1)) && (x == mx))) && 
(((y == ((my+1)+1)) && (x == mx)) || (y == ((my+1)+1))))))))) && 
(((y == (my+8)) && 0) || 
((0 && (y == ((my+1)+1))) || 
(
(((0 && (y == (3+my))) || (y == (3+my))) && 
((0 && (y == (3+my))) || ((x == (mx+4)) || (x == mx)))) || 
((0 && (y == my)) || ((y == my) && (x == mx)) || 
((x == (mx+1)) && (y == my)) || 
(
((0 && (y == (my+1))) || 
((x == mx) || (x == ((mx+1)+1)))) && ((0 && (y == (my+1))) || (y == (my+1))))) || 
(
((x == (mx+3)) || ((y == ((my+1)+1)) && (x == mx))) && 
(((y == ((my+1)+1)) && (x == mx)) || (y == ((my+1)+1))))) || 
(
(
(((y == (5+my)) && (x == mx)) || 
(((x == (mx+6)) && (y == (5+my))) || 
((y == (5+my)) && 0)) || 
(0 || ((y == (4+my)) && ((x == (mx+5)) || (x == mx))))) && 
((y == (4+my)) || 
(((y == (5+my)) && (x == mx)) || 
(((x == (mx+6)) && (y == (5+my))) || 
((y == (5+my)) && 0))))) || 
(((x == (8+mx)) && (y == (my+7))) || 
((y == (my+7)) && (x == mx)) || ((y == (my+7)) && 0) || 
((0 || ((x == (mx+7)) || (x == mx))) && (y == (6+my))))) || 
(((x == (mx+9)) && (y == (my+8))) || 
((y == (my+8)) && 
((x == (mx+7)) || ((x == mx) || (x == (mx+6))) || 
(x == (8+mx))))) || ((x == mx) || ((x == (mx+6)) || 0))))) || 
(
(0 || 
(((y == (my+11)) && ((x == (mx+1)) || (x == mx))) || 
((y == (my+11)) && ((x == (mx+4)) || (x == (mx+7)))))) && (y == (my+11))) || 
((0 && (y == (my+13))) || 
(
((x == (8+mx)) || ((y == (my+13)) && (x == (mx+5)))) && 
(((y == (my+13)) && (x == (mx+5))) || (y == (my+13))))))) || 
(
((x == (mx+4)) || (x == mx) || (x == (mx+7)) || 
(0 && (y == (12+my)))) && ((y == (12+my)) || (0 && (y == (12+my))))) || 
(0 || 
(((y == (my+15)) && 0) || 
((y == (my+15)) && ((x == (mx+6)) || (x == (mx+7)))))))) ? 4'b1111 : 4'b0;
endmodule

