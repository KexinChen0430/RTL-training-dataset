
module c_mat_mult(input_a,input_b,result);

  parameter  dim1_width = 1;
  parameter  dim2_width = 1;
  parameter  dim3_width = 1;
  input  [0:(dim1_width*dim2_width)+(-1)] input_a;
  input  [0:(dim2_width*dim3_width)+(-1)] input_b;
  output [0:(dim1_width*dim3_width)+(-1)] result;
  wire [0:(dim1_width*dim3_width)+(-1)] result;

  
  generate
      genvar row;
      for (row = 0; row < dim1_width; row = row+1)
          begin : rows
            genvar col;
            for (col = 0; col < dim3_width; col = col+1)
                begin : cols
                  wire [0:dim2_width+(-1)] products;

                  genvar idx;
                  for (idx = 0; idx < dim2_width; idx = idx+1)
                      begin : idxs
                        assign products[idx] = input_b[col+(idx*dim3_width)] & input_a[idx+(dim2_width*row)];
                      end
                  assign result[col+(dim3_width*row)] = ^products;
                end
          end
  endgenerate

endmodule

