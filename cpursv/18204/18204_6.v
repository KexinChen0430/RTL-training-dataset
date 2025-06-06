
module complex(input  [7:0] x,
               input  [7:0] y,
               output out);

  wire [9:0] and_outputs;
  wire [4:0] or_outputs;

  genvar i;
  
  generate
      for (i = 0; i < 8; i = i+1)
          begin : and_1st_row
            assign and_outputs[i] = y[i] & x[i];
          end
      for (i = 0; i < 4; i = i+1)
          begin : or_2nd_row
            assign or_outputs[i] = and_outputs[2*i] | and_outputs[1+(2*i)];
          end
      assign and_outputs[8] = or_outputs[0] & or_outputs[1];
      assign and_outputs[9] = or_outputs[3] & or_outputs[2];
      assign or_outputs[4] = and_outputs[8] | and_outputs[9];
  endgenerate

  assign out = or_outputs[4];
endmodule

