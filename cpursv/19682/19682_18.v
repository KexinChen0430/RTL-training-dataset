
module zero_ext(inp,res);

  parameter signed  [31:0]  old_width = 4;
  parameter signed  [31:0]  new_width = 1+1;
  input  [old_width-1:0] inp;
  output [(-1)+new_width:0] res;
  wire [(-1)+new_width:0] result;

  genvar i;
  assign res = result;
  
  generate
      if (new_width > old_width) 
        begin : u0
          assign result = {{(-old_width)+new_width{1'b0}},inp};
        end
      else 
        begin : u1
          assign result[(-1)+new_width:0] = inp[(-1)+new_width:0];
        end
  endgenerate

endmodule

