
module region_mouse_white(input  [10:0] x,
                          input  [10:0] y,
                          input  [10:0] mx,
                          input  [10:0] my,
                          output [3:0] yes);

  assign yes = (((x == (mx+6)) && (y == (my+14))) || 
               (((x == (mx+7)) && (y == (my+14))) || 
(0 && (y == (my+14)))) || 
               (0 || 
(
((y == (my+11)) && 
(((y == (my+11)) && (x == (mx+6))) || (x == (5+mx)))) || 
(
((y == (9+my)) || 
((y == (10+my)) && 
(
((y == (10+my)) && 
((x == (5+mx)) || (x == (4+mx)) || (x == (mx+1)))) || 0)) || 
(
(
(
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0) || 
(((0 || (x == (mx+7))) && (y == (7+my))) || 
(
((x == (mx+6)) || (x == (5+mx)) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)))) && (y == (7+my))))) && 
(
(
((0 && (y == (my+8))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))))) && ((y == (my+8)) || (0 && (y == (my+8))))) || 
(
(0 || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || ((x == (mx+7)) || (x == (mx+6)))) || 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))) || 
(0 || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || ((x == (mx+7)) || (x == (mx+6)))))))) && 
(
(
((0 && (y == (my+8))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))))) && ((y == (my+8)) || (0 && (y == (my+8))))) || 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))) || (y == (7+my)) || 
(
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))))))) && 
(
(
(
((y == (9+my)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0)) || 
((y == (10+my)) || 
(
(
(
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0) || 
(((0 || (x == (mx+7))) && (y == (7+my))) || 
(
((x == (mx+6)) || (x == (5+mx)) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)))) && (y == (7+my))))) && 
(
(
((0 && (y == (my+8))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))))) && ((y == (my+8)) || (0 && (y == (my+8))))) || 
(
(0 || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || ((x == (mx+7)) || (x == (mx+6)))) || 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))) || 
(0 || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || ((x == (mx+7)) || (x == (mx+6)))))))) && 
(
(
((0 && (y == (my+8))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))))) && ((y == (my+8)) || (0 && (y == (my+8))))) || 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))) || (y == (7+my)) || 
(
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))))))))) && 
((x == (5+mx)) || 0 || ((x == (mx+1)) || (x == (4+mx))))) || 
(
((y == (9+my)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0)) || 
(
((0 && (y == (my+8))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))))) && ((y == (my+8)) || (0 && (y == (my+8))))) || 
(
(
(
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) || 
(
((x == (mx+6)) || (x == (5+mx)) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)))) && (y == (7+my))) || ((x == (mx+7)) && (y == (7+my))) || (y == (7+my))) && 
(
(
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) || 
(
((x == (mx+6)) || (x == (5+mx)) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)))) && (y == (7+my))) || ((x == (mx+7)) && (y == (7+my))) || 0)) || (y == (my+11)))) && 
(0 || 
((y == (9+my)) && 
(((x == (5+mx)) && (y == (9+my))) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx))))) || 
(
(
((y == (my+8)) || 
(
(
(
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) || 
(
((x == (mx+6)) || (x == (5+mx)) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)))) && (y == (7+my))) || ((x == (mx+7)) && (y == (7+my))) || (y == (7+my))) && 
(
(
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) || 
(
((x == (mx+6)) || (x == (5+mx)) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)))) && (y == (7+my))) || ((x == (mx+7)) && (y == (7+my))) || 0))) && 
(
(
(
(
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) || 
(
((x == (mx+6)) || (x == (5+mx)) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)))) && (y == (7+my))) || ((x == (mx+7)) && (y == (7+my))) || (y == (7+my))) && 
(
(
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || (y == (6+my)) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4)))))) && 
(
(
((x == (mx+2)) || 
((x == (mx+1)) || 
(0 || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))))) || (y == (my+3))) && 
((y == (my+3)) || 
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))))) && 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || 
((y == (my+4)) || 
(
((y == (my+3)) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(0 || 
((y == (my+2)) && ((x == (mx+1)) || (x == (mx+2))))) && (y == (my+2)))))) && 
((x == (mx+2)) || ((x == (mx+1)) || (x == (3+mx)) || 0))) || 
(
(
(0 || 
((y == (my+5)) && 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx))))))) && (y == (my+5))) || 
(((y == (my+2)) && 0) || 
(((y == (my+2)) && (x == (mx+1))) || 
(
(((y == (my+1)) || (y == (my+2))) && 
((y == (my+2)) || 
(0 || ((x == (mx+1)) && (y == (my+1))))) && (y == (my+1)) && 
(0 || ((x == (mx+1)) && (y == (my+1))))) || ((x == (mx+2)) && (y == (my+2))))))) || 
((x == (mx+1)) || (x == (mx+2)) || 
((x == (5+mx)) || ((x == (3+mx)) || (x == (4+mx)))) || 0 || (x == (mx+6))) || 
(((y == (my+4)) || (0 && (y == (my+4)))) && 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)) || (0 && (y == (my+4))))))) || 
(
((x == (mx+6)) || (x == (5+mx)) || 
((x == (4+mx)) || ((x == (mx+1)) || (x == (mx+2))) || 
(x == (3+mx)))) && (y == (7+my))) || ((x == (mx+7)) && (y == (7+my))) || 0)) || ((x == (5+mx)) || (x == (4+mx))) || 
((x == (mx+2)) || (x == (3+mx)) || (x == (mx+1))))) || 
((y == (10+my)) && 
(
((y == (10+my)) && 
((x == (5+mx)) || (x == (4+mx)) || (x == (mx+1)))) || 0)) || (0 && (y == (my+8)))))) || 
(
((y == (12+my)) && 
((x == (mx+6)) || (x == (5+mx)) || 0)) || 
(((y == (13+my)) || ((y == (13+my)) && 0)) && 
((x == (mx+7)) || (x == (mx+6)) || ((y == (13+my)) && 0)))) || (0 && (y == (my+11)))))) ? 4'b1111 : 4'b0;
endmodule

