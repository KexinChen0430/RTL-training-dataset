
module SB_CARRY(output CO,
                input  I0,I1,CI);

  assign CO = (I1 || (CI && I0)) && (I0 || ((I1 || I0) && CI));
endmodule

