
module region_mouse_black(input  [10:0] x,
                          input  [10:0] y,
                          input  [10:0] mx,
                          input  [10:0] my,
                          output [3:0] yes);

  assign yes = (
(
(((y == (my+15)) && 0) || 
((x == (7+mx)) || (x == (mx+6)))) && (((y == (my+15)) && 0) || (y == (my+15)))) || 
               (
(
(
((y == (my+13)) && 
(0 || ((x == (mx+5)) || (x == (mx+8))))) || 
(
(
(
(
((y == (8+my)) || 
(((y == (7+my)) && (x == mx)) || 
((x == (mx+8)) && (y == (7+my))) || ((y == (7+my)) && 0) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0))) || 
((y == (6+my)) || 
(((y == (5+my)) && 0) || 
(((x == (mx+6)) || (x == mx)) && (y == (5+my)))))))) && 
((y == (8+my)) || 
(
(
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || (y == (5+my))) && 
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || 0)) || 
(0 || ((x == mx) || (x == (7+mx))) || 
(((y == (7+my)) && (x == mx)) || 
((x == (mx+8)) && (y == (7+my))) || ((y == (7+my)) && 0))))) && 
((x == (9+mx)) || (x == (mx+8)) || 0 || 
((x == (mx+6)) || (x == mx) || (x == (7+mx))) || 
(
(
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || (y == (5+my))) && 
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || 0)) || 
(((y == (7+my)) && (x == mx)) || 
((x == (mx+8)) && (y == (7+my))) || ((y == (7+my)) && 0) || ((y == (6+my)) && 0) || 
(((x == mx) || (x == (7+mx))) && (y == (6+my))))))) || (0 || ((x == (mx+6)) || (x == mx)))) && 
(
(
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || (y == (5+my))) && 
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || 0)) || 
(((y == (7+my)) && (x == mx)) || 
((x == (mx+8)) && (y == (7+my))) || ((y == (7+my)) && 0) || ((y == (6+my)) && 0) || 
(((x == mx) || (x == (7+mx))) && (y == (6+my)))) || (y == (my+9)) || 
(
((x == (9+mx)) || (x == (mx+8)) || 0 || 
((x == (mx+6)) || (x == mx) || (x == (7+mx)))) && (y == (8+my))))) || 
((y == (11+my)) || 
(
(
((x == (mx+6)) || 
(((x == (1<<<1+mx)) || (x == (mx+3)) || (x == mx)) && 
(y == (10+my)))) && 
(
(((x == (1<<<1+mx)) || (x == (mx+3)) || (x == mx)) && 
(y == (10+my))) || (y == (10+my)))) || (0 && (y == (10+my))))))) && 
(0 || 
((x == (4+mx)) || 
((x == (1+mx)) || ((x == mx) || (x == (7+mx))))) || 
(
(
(
((x == (mx+6)) || 
(((x == (1<<<1+mx)) || (x == (mx+3)) || (x == mx)) && 
(y == (10+my)))) && 
(
(((x == (1<<<1+mx)) || (x == (mx+3)) || (x == mx)) && 
(y == (10+my))) || (y == (10+my)))) || (0 && (y == (10+my))) || 
(
(
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || (y == (5+my))) && 
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || 0)) || 
(((y == (7+my)) && (x == mx)) || 
((x == (mx+8)) && (y == (7+my))) || ((y == (7+my)) && 0) || ((y == (6+my)) && 0) || 
(((x == mx) || (x == (7+mx))) && (y == (6+my)))) || (y == (my+9)) || 
(
((x == (9+mx)) || (x == (mx+8)) || 0 || 
((x == (mx+6)) || (x == mx) || (x == (7+mx)))) && (y == (8+my))))) && 
(0 || ((x == (mx+6)) || (x == mx)) || 
(
(
((x == (mx+6)) || 
(((x == (1<<<1+mx)) || (x == (mx+3)) || (x == mx)) && 
(y == (10+my)))) && 
(
(((x == (1<<<1+mx)) || (x == (mx+3)) || (x == mx)) && 
(y == (10+my))) || (y == (10+my)))) || (0 && (y == (10+my)))) || 
(
((y == (8+my)) || 
(((y == (7+my)) && (x == mx)) || 
((x == (mx+8)) && (y == (7+my))) || ((y == (7+my)) && 0) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0))) || 
((y == (6+my)) || 
(((y == (5+my)) && 0) || 
(((x == (mx+6)) || (x == mx)) && (y == (5+my)))))))) && 
((y == (8+my)) || 
(
(
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || (y == (5+my))) && 
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || 0)) || 
(0 || ((x == mx) || (x == (7+mx))) || 
(((y == (7+my)) && (x == mx)) || 
((x == (mx+8)) && (y == (7+my))) || ((y == (7+my)) && 0))))) && 
((x == (9+mx)) || (x == (mx+8)) || 0 || 
((x == (mx+6)) || (x == mx) || (x == (7+mx))) || 
(
(
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || (y == (5+my))) && 
(
(
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
(
(0 && 
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx))))))) || 
(
(((y == my) && 0) || 
((y == ((1+my)+1)) || 
(((y == my) && (x == mx)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || ((y == my) && (x == (1+mx)))))) && ((x == mx) || (x == (mx+3)))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my)))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))) || (y == (5+my)))) && 
((x == (mx+6)) || (x == mx) || 
(
((y == (my+3)) && 
(0 || 
(
(((x == (4+mx)) && (y == (my+3))) || (y == (my+3))) && (((x == (4+mx)) && (y == (my+3))) || (x == mx))))) || 
((0 && (y == ((1+my)+1))) || 
(
(((x == mx) || (x == (mx+3))) && (y == ((1+my)+1))) || 
(
(
((y == my) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))) && ((x == (1+mx)) || (x == mx) || 0)) || 
(((y == (1+my)) && (x == mx)) || 
((0 || (x == (1<<<1+mx))) && (y == (1+my))))))) || 
(((y == (4+my)) && (x == mx)) || 
(((x == (mx+5)) && (y == (4+my))) || 
((y == (4+my)) && 0)))))) || 0)) || 
(((y == (7+my)) && (x == mx)) || 
((x == (mx+8)) && (y == (7+my))) || ((y == (7+my)) && 0) || ((y == (6+my)) && 0) || 
(((x == mx) || (x == (7+mx))) && (y == (6+my))))))))) || 
((y == (my+13)) && 
(0 || ((x == (mx+5)) || (x == (mx+8))))))) || 
((y == (my+12)) && 
(0 || ((x == (7+mx)) || (x == (4+mx))) || (x == mx))) || 0 || 
(((y == (my+14)) && 0) || 
(((x == (mx+5)) && (y == (my+14))) || 
((x == (mx+8)) && (y == (my+14))))))) ? 4'b1111 : 4'b0;
endmodule

