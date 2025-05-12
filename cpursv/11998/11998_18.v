
module SB_CARRY(output CO,
                input  I0,I1,CI);

  assign CO = (CI && (I1 || I0)) || (I0 && ((CI && I0) || I1));
endmodule

