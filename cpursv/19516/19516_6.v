
module zet_next_or_not(input  [1:0] prefix,
                       input  [7:1] opcode,
                       input  cx_zero,
                       input  zf,
                       input  ext_int,
                       output next_in_opco,
                       output next_in_exec);

  wire exit_z,cmp_sca,exit_rep,valid_ops;

  assign cmp_sca = opcode[2] & opcode[1];
  assign exit_z = prefix[0] ? (cmp_sca ? ~zf : 1'b0) : 
                  cmp_sca ? zf : 1'b0;
  assign exit_rep = exit_z | cx_zero;
  assign valid_ops = (opcode[7:1] == 7'b1010_010) || 
                     (opcode[7:1] == 7'b1010_111) || 
                     ((opcode[7:1] == 7'b1010_110) || 
((opcode[7:1] == 7'b1010_011) || 
(opcode[7:1] == 7'b1010_101)));
  assign next_in_exec = !ext_int && (!exit_rep && (prefix[1] && valid_ops));
  assign next_in_opco = prefix[1] && (valid_ops && cx_zero);
endmodule

