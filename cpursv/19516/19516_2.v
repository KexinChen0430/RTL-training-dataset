
module zet_next_or_not(input  [1:0] prefix,
                       input  [7:1] opcode,
                       input  cx_zero,
                       input  zf,
                       input  ext_int,
                       output next_in_opco,
                       output next_in_exec);

  wire exit_z,cmp_sca,exit_rep,valid_ops;

  assign cmp_sca = opcode[1] & opcode[2];
  assign exit_z = prefix[0] ? (cmp_sca ? ~zf : 1'b0) : 
                  cmp_sca ? zf : 1'b0;
  assign exit_rep = cx_zero | exit_z;
  assign valid_ops = (opcode[7:1] == 7'b1010_101) || 
                     ((opcode[7:1] == 7'b1010_011) || 
(opcode[7:1] == 7'b1010_110)) || 
                     ((opcode[7:1] == 7'b1010_010) || 
(opcode[7:1] == 7'b1010_111));
  assign next_in_exec = valid_ops && (prefix[1] && (!exit_rep && !ext_int));
  assign next_in_opco = cx_zero && (valid_ops && prefix[1]);
endmodule

