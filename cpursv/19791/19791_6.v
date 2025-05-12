
module AND4(input  A,B,C,D,
            output Y);

  assign Y = (B & (C & A)) & D;
endmodule

