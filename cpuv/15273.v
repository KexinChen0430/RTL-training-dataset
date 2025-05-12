module top;
  initial begin
    $monitor("%.3f", $realtime, 
             sml_const.test, 
             sml_var.test, 
             sml_const.out_g, 
             sml_const.out_u, 
             sml_const.out_m, 
             sml_const.out_s, 
             sml_var.out_g, 
             sml_var.out_u, 
             sml_const.out_f, 
             med_const.out_f, 
             lrg_const.out_f, 
             med_const.test, 
             med_var.test, 
             med_const.out_g, 
             med_const.out_u, 
             med_const.out_m, 
             med_const.out_s, 
             med_var.out_g, 
             med_var.out_u, 
             lrg_const.test, 
             lrg_var.test, 
             lrg_const.out_g, 
             lrg_const.out_u, 
             lrg_const.out_m, 
             lrg_const.out_s, 
             lrg_var.out_g, 
             lrg_var.out_u 
             );
    #1.3 $finish(0);
  end
endmodule