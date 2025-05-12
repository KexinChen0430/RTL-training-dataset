
module zbus(input  iorq_n,
            input  rd_n,
            input  wr_n,
            input  m1_n,
            output iorq1_n,
            output iorq2_n,
            input  iorqge1,
            input  iorqge2,
            input  porthit,
            output drive_ff);

  assign iorq1_n = porthit | iorq_n;
  assign iorq2_n = iorqge1 | iorq1_n;
  assign drive_ff = (~(m1_n | iorq_n) | ~rd_n) & (~(iorq2_n | iorqge2) | ~(m1_n | iorq_n));
endmodule

