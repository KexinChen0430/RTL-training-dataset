module. 
assign WRITE_OUT_BUS[15] = READ_OUT_BUS[15] | !R1C | !RSB        ; 
assign WRITE_OUT_BUS[14] = READ_OUT_BUS[14] | !R1C               ; 
assign WRITE_OUT_BUS[13] = READ_OUT_BUS[13] | !R1C | !RB14       ; 
assign WRITE_OUT_BUS[12] = READ_OUT_BUS[12] | !R1C               ; 
assign WRITE_OUT_BUS[11] = READ_OUT_BUS[11] | !R1C               ; 
assign WRITE_OUT_BUS[10] = READ_OUT_BUS[10] | !R1C | !R2000      ; 
assign WRITE_OUT_BUS[ 9] = READ_OUT_BUS[ 9] | !R1C               ; 
assign WRITE_OUT_BUS[ 8] = READ_OUT_BUS[ 8] | !R1C               ; 
assign WRITE_OUT_BUS[ 7] = READ_OUT_BUS[ 7] | !R1C               ; 
assign WRITE_OUT_BUS[ 6] = READ_OUT_BUS[ 6] | !R1C               ; 
assign WRITE_OUT_BUS[ 5] = READ_OUT_BUS[ 5] | !R1C               ; 
assign WRITE_OUT_BUS[ 4] = READ_OUT_BUS[ 4] | !R1C | !R22 | !R24 ; 
assign WRITE_OUT_BUS[ 3] = READ_OUT_BUS[ 3] | !R1C               ; 
assign WRITE_OUT_BUS[ 2] = READ_OUT_BUS[ 2] | !R1C |        !R24 ; 
assign WRITE_OUT_BUS[ 1] = READ_OUT_BUS[ 1] | !R1C | !R2  | !R22 ; 
assign WRITE_OUT_BUS[ 0] = READ_OUT_BUS[ 0] | !R1                ; 
endmodule 