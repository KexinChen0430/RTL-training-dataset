
module AND4(input  A,B,C,D,
            output Y);

  assign Y = B & (A & (D & C));
endmodule

