module sub_mod
(
   input [8+4-1:0][7:0] add_left,
   input [8-4-1:0][7:0] substract_left,
   input [8*4-1:0][7:0] multiply_left,
   input [8/4-1:0][7:0] divide_left,
   input [7:0][8+4-1:0] add_right,
   input [7:0][8-4-1:0] substract_right,
   input [7:0][8*4-1:0] multiply_right,
   input [7:0][8/4-1:0] divide_right,
);
endmodule