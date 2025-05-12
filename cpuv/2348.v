module top_mod
(
   input [8+4-1:0] [7:0] add_left,              
   input [7:0] [11:0]   add_right,              
   input [8/4-1:0] [7:0] divide_left,           
   input [7:0] [1:0]    divide_right,           
   input [8*4-1:0] [7:0] multiply_left,         
   input [7:0] [31:0]   multiply_right,         
   input [8-4-1:0] [7:0] substract_left,        
   input [7:0] [3:0]    substract_right        
);
   sub_mod sub_mod_i
      (
       .add_left                        (add_left),
       .substract_left                  (substract_left),
       .multiply_left                   (multiply_left),
       .divide_left                     (divide_left),
       .add_right                       (add_right),
       .substract_right                 (substract_right),
       .multiply_right                  (multiply_right),
       .divide_right                    (divide_right));
endmodule