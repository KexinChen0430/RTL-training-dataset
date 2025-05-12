
module cycloneiv_jtag(tms,tck,tdi,tdoutap,tdouser,tdo,tmsutap,tckutap,tdiutap,
                      shiftuser,clkdruser,updateuser,runidleuser,usr1user);

  input  tms;
  input  tck;
  input  tdi;
  input  tdoutap;
  input  tdouser;
  output tdo;
  output tmsutap;
  output tckutap;
  output tdiutap;
  output shiftuser;
  output clkdruser;
  output updateuser;
  output runidleuser;
  output usr1user;
  parameter  lpm_type = cycloneiv_jtag;


endmodule

