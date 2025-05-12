
module pad_lsb(inp,res);

  parameter signed  [31:0]  orig_width = 4;
  parameter signed  [31:0]  new_width = 1+1;
  input  [(0-1)+orig_width:0] inp;
  output [(0-1)+new_width:0] res;
  parameter signed  [31:0]  pad_pos = (new_width+(-orig_width))+(0-1);
  wire [(0-1)+new_width:0] result;

  genvar i;
  assign res = result;
  
  generate
      if (new_width >= orig_width) 
        begin : u0
          assign result[(0-1)+new_width:new_width+(-orig_width)] = inp[(0-1)+orig_width:0];
        end
        
  endgenerate

  
  generate
      if (pad_pos >= 0) 
        begin : u1
          assign result[pad_pos:0] = {1+pad_pos{1'b0}};
        end
        
  endgenerate

endmodule

