module sub
  (
   input wire  signal_i,
   output wire signal_o,
   dummy_if.master dummy_in,
   dummy_if.slave dummy_out
   );
   assign dummy_in.signal = signal_i;
   assign signal_o = dummy_out.signal;
endmodule