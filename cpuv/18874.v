module pull( );
   input clk;
   input rst_rnpha;
   input [4:0] lenar_rxp;
   input       rem_rpd;
   input       d_rews;
   output [4:0] d_len;
   output      d_val;
  req test432_gbe5();
   req gbe9_vreos();
   fifo #(5)  gbe2_pull_req ();
   fifo #(5)
      gbe1_pull_req_fifo( );
endmodule