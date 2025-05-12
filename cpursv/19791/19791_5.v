
module AND4(input  A,B,C,D,
            output Y);

  assign Y = C & ((B & D) & A);
endmodule

