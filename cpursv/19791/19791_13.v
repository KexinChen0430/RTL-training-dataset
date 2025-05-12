
module AND4(input  A,B,C,D,
            output Y);

  assign Y = (A & (C & B)) & D;
endmodule

