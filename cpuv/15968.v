module c_binary_op (data_in, data_out);
`include "c_constants.v"
parameter num_ports = 2;
parameter width = 1;
parameter op = `BINARY_OP_XOR;
input [0:width*num_ports-1] data_in;
output [0:width-1] data_out;
wire [0:width-1] data_out;
generate
   genvar i;
   for(i = 0; i < width; i = i + 1)
     begin:bit_positions 
        wire [0:num_ports-1] data;
        genvar j;
        for(j = 0; j < num_ports; j = j + 1)
          begin:input_ports 
             assign data[j] = data_in[j*width+i];
          end
        case(op)
          `BINARY_OP_AND:
            assign data_out[i] = &data;
          `BINARY_OP_NAND:
            assign data_out[i] = ~&data;
          `BINARY_OP_OR:
            assign data_out[i] = |data;
          `BINARY_OP_NOR:
            assign data_out[i] = ~|data;
          `BINARY_OP_XOR:
            assign data_out[i] = ^data;
          `BINARY_OP_XNOR:
            assign data_out[i] = ~^data;
        endcase
     end
endgenerate
endmodule