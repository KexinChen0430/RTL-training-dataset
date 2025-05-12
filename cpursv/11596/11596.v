
module MuxN_5(input  io_ins_0,
              input  io_ins_1,
              input  io_sel,
              output io_out);

  wire _GEN_0;
  wire _GEN_1;

  assign _GEN_1 = io_sel ? io_ins_1 : io_ins_0;
  assign io_out = _GEN_0;
  assign _GEN_0 = _GEN_1;
endmodule

