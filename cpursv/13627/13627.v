
module signals;

  assign ram_ce = 1;
  assign ram_we = we;
  assign ram_oe = 1;
  assign ram_a[17:0] = {frame[2:7],ad[4:15]};
  assign ram_d = we ? rdt : 16'hzzzz;
endmodule

