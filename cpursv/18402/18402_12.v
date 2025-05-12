
module SB_CARRY(output CO,
                input  I0,I1,CI);

  assign CO = (I0 && I1) || (CI && (I0 || I1));
endmodule

