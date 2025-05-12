
module SPDT_RELAY(COIL1,COIL2,ARM,NC,NO);

  inout  COIL1,COIL2,ARM,NC,NO;
  wire 
       coil = ((COIL2 === 1'b0) && (COIL1 === 1'b1)) || 
(
((COIL2 === 1'b0) && (COIL2 === 1'b1) && 
((COIL2 === 1'b0) && (COIL1 === 1'b1))) || 
(
((COIL2 === 1'b0) && (COIL2 === 1'b1) && (COIL1 === 1'b0)) || 
((COIL2 === 1'b0) && (COIL1 === 1'b1) && (COIL1 === 1'b0) && 
(COIL2 === 1'b1)))) || 
((COIL1 === 1'b1) && 
((COIL1 === 1'b0) && 
(
((COIL1 === 1'b0) || 
(((COIL2 === 1'b0) && (COIL1 === 1'b1)) || 
((COIL1 === 1'b0) && (COIL2 === 1'b0))) || 
(((COIL1 === 1'b0) && (COIL2 === 1'b1)) || 
((COIL1 === 1'b1) || 
(
((COIL2 === 1'b0) && (COIL1 === 1'b1) && (COIL1 === 1'b0)) || 
((COIL1 === 1'b0) && (COIL2 === 1'b1) && (COIL1 === 1'b1)))))) && 
(
((COIL2 === 1'b0) && (COIL1 === 1'b1) && (COIL1 === 1'b0)) || (COIL2 === 1'b1) || 
(
(((COIL2 === 1'b0) && (COIL1 === 1'b1)) || 
((COIL1 === 1'b0) && (COIL2 === 1'b0))) && (COIL2 === 1'b1)) || (COIL2 === 1'b0))))) || ((COIL1 === 1'b0) && (COIL2 === 1'b1));
  wire #1  dly_coil = coil;
  wire  coil_on = coil & dly_coil;
  wire  coil_off = !dly_coil & !coil;

  tranif1 t1(ARM,NC,coil_off);
  tranif1 t2(ARM,NO,coil_on);
endmodule

