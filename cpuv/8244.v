module CARRY_COUT_PLUG(input CIN, output COUT);
assign COUT = CIN;
  specify
    (CIN => COUT) = 0;
  endspecify
endmodule