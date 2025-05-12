
module SB_CARRY(output CO,
                input  I0,I1,CI);

  assign CO = (I0 && CI) || (CI && I1) || (I0 && I1);
endmodule

