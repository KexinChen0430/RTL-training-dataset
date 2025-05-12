module twentynm_lcell_comb (output combout, cout, sumout,
                            input  dataa, datab, datac, datad,
                            input  datae, dataf, datag, cin,
                            input  sharein);
parameter lut_mask      = 64'hFFFFFFFFFFFFFFFF;
parameter dont_touch    = "off";
parameter lpm_type      = "twentynm_lcell_comb";
parameter shared_arith  = "off";
parameter extended_lut  = "off";
initial begin
  $display("Simulation model is still under investigation\n");
end
endmodule