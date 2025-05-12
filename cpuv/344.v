module cg_test1;
   covergroup counter1 @ (posedge cyc);
      cyc_bined : coverpoint cyc {
         bins zero    = {0};
         bins low    = {1,5};
         bins mid   = {[5:$]};
      }
      value_and_toggle:
         cross cyc_value, toggle;
   endgroup
endmodule