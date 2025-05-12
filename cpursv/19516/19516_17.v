
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
                     (opcode[7:1] == 7'b1010_110) || 
                     ((opcode[7:1] == 7'b1010_011) || 
(opcode[7:1] == 7'b1010_111) || (opcode[7:1] == 7'b1010_101));
  assign next_in_exec = prefix[1] && valid_ops && (!ext_int && !exit_rep);
  assign next_in_opco = cx_zero && prefix[1] && valid_ops;
endmodule

