
module vjtag(ir_in,tck,tdi,virtual_state_cdr,virtual_state_cir,
             virtual_state_e1dr,virtual_state_e2dr,virtual_state_pdr,
             virtual_state_sdr,virtual_state_udr,virtual_state_uir,ir_out,
             tdo,virtual_state_cdr,virtual_state_cir,virtual_state_e1dr,
             virtual_state_e2dr,virtual_state_pdr,virtual_state_sdr,
             virtual_state_udr,virtual_state_uir);

  input  [1:0] ir_out;
  input  tdo;
  output [1:0] ir_in;
  output tck;
  output tdi;
  output virtual_state_cdr;
  output virtual_state_cir;
  output virtual_state_e1dr;
  output virtual_state_e2dr;
  output virtual_state_pdr;
  output virtual_state_sdr;
  output virtual_state_udr;
  output virtual_state_uir;


endmodule

