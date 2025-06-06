
module region_mouse_white(input  [10:0] x,
                          input  [10:0] y,
                          input  [10:0] mx,
                          input  [10:0] my,
                          output [3:0] yes);

  assign yes = (
(((x == (6+mx)) || 0 || (x == (7+mx))) && 
(
(
((x == (6+mx)) || (0 || (x == (5+mx))) || 
(
(
(
(((y == (my+2)) || (y == (1+my))) && 
((y == (my+2)) || ((x == (1+mx)) || 0)) && (0 || ((x == (2+mx)) || (x == (1+mx))))) || 
(((y == (1+my)) && 0) || 
((x == (1+mx)) && (y == (1+my)))) || ((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))) && 
((0 && (y == (my+2))) || 
(
(((x == (2+mx)) || (x == (1+mx))) && (y == (my+2))) || 
(((y == (1+my)) && 0) || 
((x == (1+mx)) && (y == (1+my)))) || (y == (my+3))))) || (0 && (y == (my+3))) || 
(
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx))) || ((x == (6+mx)) || 0)) && (y == (6+my))) || 
((y == (4+my)) && 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)) || 
(0 || (x == (mx+4))))) || 
(
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)) || 
((x == (mx+4)) || (x == (5+mx)) || 0)) && (y == (my+5))) || 
(
((y == (my+7)) && 
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx))) || ((x == (6+mx)) || 0))) || ((x == (7+mx)) && (y == (my+7)))) || 
(
(((y == (my+8)) || (0 && (y == (my+8)))) && 
((0 && (y == (my+8))) || 
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))))) || 
(
(
(((x == (mx+4)) || (x == (5+mx))) && (y == (my+9))) || 
((y == (my+9)) && 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))) || 0) && (y == (my+9))))) || 
((y == (10+my)) && 
((x == (mx+4)) || (x == (1+mx)) || (0 || (x == (5+mx))))) || ((x == (6+mx)) || 0 || (x == (7+mx)))) && 
((y == (my+12)) || 
(((y == (10+my)) && 0) || 
(
(((x == (mx+4)) || (x == (5+mx))) && (y == (10+my))) || ((y == (10+my)) && (x == (1+mx))) || 
(
(
(
(((y == (my+2)) || (y == (1+my))) && 
((y == (my+2)) || ((x == (1+mx)) || 0)) && (0 || ((x == (2+mx)) || (x == (1+mx))))) || 
(((y == (1+my)) && 0) || 
((x == (1+mx)) && (y == (1+my)))) || ((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))) && 
((0 && (y == (my+2))) || 
(
(((x == (2+mx)) || (x == (1+mx))) && (y == (my+2))) || 
(((y == (1+my)) && 0) || 
((x == (1+mx)) && (y == (1+my)))) || (y == (my+3))))) || (0 && (y == (my+3))) || 
(
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx))) || ((x == (6+mx)) || 0)) && (y == (6+my))) || 
((y == (4+my)) && 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)) || 
(0 || (x == (mx+4))))) || 
(
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)) || 
((x == (mx+4)) || (x == (5+mx)) || 0)) && (y == (my+5))) || 
(
((y == (my+7)) && 
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx))) || ((x == (6+mx)) || 0))) || ((x == (7+mx)) && (y == (my+7)))) || 
(
(((y == (my+8)) || (0 && (y == (my+8)))) && 
((0 && (y == (my+8))) || 
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))))) || 
(
(
(((x == (mx+4)) || (x == (5+mx))) && (y == (my+9))) || 
((y == (my+9)) && 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))) || 0) && (y == (my+9))))))) || 
(((y == (my+11)) || ((y == (my+11)) && 0)) && 
(((y == (my+11)) && 0) || 
((x == (6+mx)) || (x == (5+mx))))) || ((x == (6+mx)) || 0 || (x == (7+mx))))) || (y == (my+14))) && 
(((y == (10+my)) && 0) || 
(
(((x == (mx+4)) || (x == (5+mx))) && (y == (10+my))) || ((y == (10+my)) && (x == (1+mx))) || 
(
(
(
(((y == (my+2)) || (y == (1+my))) && 
((y == (my+2)) || ((x == (1+mx)) || 0)) && (0 || ((x == (2+mx)) || (x == (1+mx))))) || 
(((y == (1+my)) && 0) || 
((x == (1+mx)) && (y == (1+my)))) || ((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))) && 
((0 && (y == (my+2))) || 
(
(((x == (2+mx)) || (x == (1+mx))) && (y == (my+2))) || 
(((y == (1+my)) && 0) || 
((x == (1+mx)) && (y == (1+my)))) || (y == (my+3))))) || (0 && (y == (my+3))) || 
(
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx))) || ((x == (6+mx)) || 0)) && (y == (6+my))) || 
((y == (4+my)) && 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)) || 
(0 || (x == (mx+4))))) || 
(
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)) || 
((x == (mx+4)) || (x == (5+mx)) || 0)) && (y == (my+5))) || 
(
((y == (my+7)) && 
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx))) || ((x == (6+mx)) || 0))) || ((x == (7+mx)) && (y == (my+7)))) || 
(
(((y == (my+8)) || (0 && (y == (my+8)))) && 
((0 && (y == (my+8))) || 
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))))) || 
(
(
(((x == (mx+4)) || (x == (5+mx))) && (y == (my+9))) || 
((y == (my+9)) && 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))) || 0) && (y == (my+9)))))) || 
(((y == (my+11)) || ((y == (my+11)) && 0)) && 
(((y == (my+11)) && 0) || 
((x == (6+mx)) || (x == (5+mx))))) || (y == (my+13)) || 
((0 && (y == (my+12))) || 
((y == (my+12)) && (x == (6+mx))) || ((y == (my+12)) && (x == (5+mx)))) || (y == (my+14)))) || 
               (((x == (6+mx)) && (y == (my+13))) || 
((y == (my+13)) && (x == (7+mx))) || ((y == (my+13)) && 0) || 
((0 && (y == (my+12))) || 
((y == (my+12)) && (x == (6+mx))) || ((y == (my+12)) && (x == (5+mx)))) || 0 || 
(((y == (10+my)) && 0) || 
(
(((x == (mx+4)) || (x == (5+mx))) && (y == (10+my))) || ((y == (10+my)) && (x == (1+mx))) || 
(
(
(
(((y == (my+2)) || (y == (1+my))) && 
((y == (my+2)) || ((x == (1+mx)) || 0)) && (0 || ((x == (2+mx)) || (x == (1+mx))))) || 
(((y == (1+my)) && 0) || 
((x == (1+mx)) && (y == (1+my)))) || ((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))) && 
((0 && (y == (my+2))) || 
(
(((x == (2+mx)) || (x == (1+mx))) && (y == (my+2))) || 
(((y == (1+my)) && 0) || 
((x == (1+mx)) && (y == (1+my)))) || (y == (my+3))))) || (0 && (y == (my+3))) || 
(
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx))) || ((x == (6+mx)) || 0)) && (y == (6+my))) || 
((y == (4+my)) && 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)) || 
(0 || (x == (mx+4))))) || 
(
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)) || 
((x == (mx+4)) || (x == (5+mx)) || 0)) && (y == (my+5))) || 
(
((y == (my+7)) && 
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx))) || ((x == (6+mx)) || 0))) || ((x == (7+mx)) && (y == (my+7)))) || 
(
(((y == (my+8)) || (0 && (y == (my+8)))) && 
((0 && (y == (my+8))) || 
((x == (mx+4)) || (x == (5+mx)) || 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))))) || 
(
(
(((x == (mx+4)) || (x == (5+mx))) && (y == (my+9))) || 
((y == (my+9)) && 
((x == (2+mx)) || (x == (1+mx)) || (x == (3+mx)))) || 0) && (y == (my+9)))))) || 
(((y == (my+11)) || ((y == (my+11)) && 0)) && 
(((y == (my+11)) && 0) || 
((x == (6+mx)) || (x == (5+mx)))))))) ? 4'b1111 : 4'b0;
endmodule

