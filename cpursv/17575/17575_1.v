
module hct74245(input  dir,
                input  nOE,
                inout  [7:0] A,
                inout  [7:0] B,
                output [7:0] C);

  
  specify
    (A *> C) = 100;
    (A *> B) = 10;
    (B *> A) = 10;
    (dir *> A) = 16;
    (dir *> B) = 16;
    (nOE *> A) = 16;
    (nOE *> B) = 16;
  endspecify

  assign A = nOE ? 8'bzzzzzzzz : 
             dir ? 8'bzzzzzzzz : B;
  assign B = nOE ? 8'bzzzzzzzz : 
             dir ? A : 8'bzzzzzzzz;
  assign C = A;
endmodule

