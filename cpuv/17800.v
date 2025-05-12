module sub
(
       input logic clk,
       ahb_slave_intf infc
       );
   int internal;
   always_comb internal = infc.data;
endmodule