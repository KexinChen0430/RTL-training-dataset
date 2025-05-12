module ptype_buf
  #(parameter WIDTH = 1,
    parameter type TYPE_T = logic [WIDTH-1:0])
   (output TYPE_T y,
    input TYPE_T a);
   assign y  = a;
endmodule