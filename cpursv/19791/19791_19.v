
module AND4(input  A,B,C,D,
            output Y);

  assign Y = (D & (B & A)) & C;
endmodule

