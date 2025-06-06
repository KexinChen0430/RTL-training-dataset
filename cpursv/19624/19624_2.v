
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

  assign iorq1_n = iorq_n | porthit;
  assign iorq2_n = iorq1_n | iorqge1;
  assign drive_ff = (~(iorq2_n | iorqge2) | ~(m1_n | iorq_n)) & (~rd_n | ~(m1_n | iorq_n));
endmodule

