module Select
  #(
    parameter int NUM_MASTER = 1
    )
   (
    Intf Upstream,
    Intf Downstream[NUM_MASTER]
    );
endmodule