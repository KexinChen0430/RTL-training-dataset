
module shift_division_result(quotient,fraction,res);

  parameter signed  [31:0]  q_width = 16;
  parameter signed  [31:0]  f_width = 16;
  parameter signed  [31:0]  fraction_width = 8;
  parameter signed  [31:0]  shift_value = 8;
  parameter signed  [31:0]  shift_dir = 0;
  parameter signed  [31:0]  vec_MSB = (f_width+(0-1))+q_width;
  parameter signed  [31:0]  result_MSB = ((0-1)+q_width)+fraction_width;
  parameter signed  [31:0]  result_LSB = (0-result_MSB)+vec_MSB;
  input  [(0-1)+q_width:0] quotient;
  input  [f_width+(0-1):0] fraction;
  output [result_MSB:0] res;
  wire [vec_MSB:0] vec;
  wire [vec_MSB:0] temp;

  genvar i;
  assign res = vec[vec_MSB:result_LSB];
  assign temp = {quotient,fraction};
  
  generate
      if (shift_dir == 1) 
        begin : left_shift_loop
          for (i = vec_MSB; i >= 0; i = (0-1)+i)
              begin : u0
                if (i < shift_value) 
                  begin : u1
                    assign vec[i] = 1'b0;
                  end
                else 
                  begin : u2
                    assign vec[i] = temp[i-shift_value];
                  end
              end
        end
      else 
        begin : right_shift_loop
          for (i = 0; i <= vec_MSB; i = 1+i)
              begin : u3
                if (i > ((-shift_value)+vec_MSB)) 
                  begin : u4
                    assign vec[i] = temp[vec_MSB];
                  end
                else 
                  begin : u5
                    assign vec[i] = temp[shift_value+i];
                  end
              end
        end
  endgenerate

endmodule

