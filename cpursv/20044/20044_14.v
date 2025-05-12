
module sign_ext(inp,res);

  parameter signed  [31:0]  old_width = 4;
  parameter signed  [31:0]  new_width = 1<<1;
  input  [old_width-1:0] inp;
  output [(0-1)+new_width:0] res;
  wire [(0-1)+new_width:0] result;

  assign res = result;
  
  generate
      if (new_width >= old_width) 
        begin : u0
          assign result = {{new_width-old_width{inp[old_width-1]}},inp};
        end
      else 
        begin : u1
          assign result[(0-1)+new_width:0] = inp[(0-1)+new_width:0];
        end
  endgenerate

endmodule

