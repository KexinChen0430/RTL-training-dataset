module dff (
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input CLK
);
  parameter [0:0] INIT = 1'b0;
  initial Q = INIT;
  always @(posedge CLK) Q <= D;
endmodule