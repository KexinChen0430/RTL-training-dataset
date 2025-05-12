
module temp_sense(ce,clk,clr,tsdcaldone,tsdcalo);

  input  ce;
  input  clk;
  input  clr;
  output tsdcaldone;
  output [7:0] tsdcalo;
  wire [7:0] sub_wire0;
  wire sub_wire1;
  wire [7:0]  tsdcalo = sub_wire0[7:0];
  wire  tsdcaldone = sub_wire1;

  temp_sense_alttemp_sense_v8t temp_sense_alttemp_sense_v8t_component(.ce(ce),
                                                                      .clk(clk),.clr(clr),
                                                                      .tsdcalo(sub_wire0),.tsdcaldone(sub_wire1));
endmodule

