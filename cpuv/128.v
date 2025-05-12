module ThingMuxOH
  #(
    parameter NTHINGS = 1,
    parameter M = 5
   )
   (
    input logic [NTHINGS-1:0] select_oh,
    the_intf.t things_in [NTHINGS-1:0],
    the_intf.i thing_out
    );
endmodule 