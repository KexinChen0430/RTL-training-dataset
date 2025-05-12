module Test (
   left, right,
   amt, in
   );
   input [6:0] 	amt;
   input [67:0] in;
   output wire [67:0] left;
   output wire [67:0] right;
   assign right = { << 33 {in}};
   assign left = { >> 33 {in}};
endmodule