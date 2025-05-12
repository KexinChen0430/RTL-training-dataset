
module sign_ext(inp,res);

  parameter signed  [31:0]  old_width = 4;
  parameter signed  [31:0]  new_width = 1+1;
  input  [(-1)+old_width:0] inp;
  output [(-1)+new_width:0] res;
  wire [(-1)+new_width:0] result;

  assign res = result;
  
  generate
      if (new_width >= old_width) 
        begin : u0
          assign result = {{new_width-old_width{inp[(-1)+old_width]}},inp};
        end
      else 
        begin : u1
          assign result[(-1)+new_width:0] = inp[(-1)+new_width:0];
        end
  endgenerate

endmodule

