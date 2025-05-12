
module alt_vipitc131_common_to_binary(one_hot,binary);

  parameter  NO_OF_MODES = 3;
  parameter  LOG2_NO_OF_MODES = 1<<1;
  input  [NO_OF_MODES-1:0] one_hot;
  output [(0-1)+LOG2_NO_OF_MODES:0] binary;

  
  generate
      genvar binary_pos,one_hot_pos;
      wire [(0-1)+(LOG2_NO_OF_MODES*NO_OF_MODES):0] binary_values;

      wire [(0-1)+(LOG2_NO_OF_MODES*NO_OF_MODES):0] binary_values_by_bit;

      for (one_hot_pos = 0; one_hot_pos < NO_OF_MODES; one_hot_pos = one_hot_pos+1)
          begin : to_binary_one_hot_pos
            assign binary_values[(LOG2_NO_OF_MODES*one_hot_pos)+((0-1)+LOG2_NO_OF_MODES):LOG2_NO_OF_MODES*one_hot_pos] = one_hot[one_hot_pos] ? (one_hot_pos+1) : 0;
          end
      for (binary_pos = 0; binary_pos < LOG2_NO_OF_MODES; binary_pos = 1+binary_pos)
          begin : to_binary_binary_pos
            for (one_hot_pos = 0; one_hot_pos < NO_OF_MODES; one_hot_pos = one_hot_pos+1)
                begin : to_binary_one_hot_pos
                  assign binary_values_by_bit[(binary_pos*NO_OF_MODES)+one_hot_pos] = binary_values[(LOG2_NO_OF_MODES*one_hot_pos)+binary_pos];
                end
            assign binary[binary_pos] = |binary_values_by_bit[(NO_OF_MODES+(binary_pos*NO_OF_MODES))-1:binary_pos*NO_OF_MODES];
          end
  endgenerate

endmodule

