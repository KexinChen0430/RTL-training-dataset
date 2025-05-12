
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
  assign iorq2_n = iorq1_n | iorqge1;
  assign drive_ff = (~rd_n | ~(iorq_n | m1_n)) & (~(iorqge2 | iorq2_n) | ~(iorq_n | m1_n));
endmodule

