
module except(clk,opa,opb,inf,ind,qnan,snan,opa_nan,opb_nan,opa_00,opb_00,
              opa_inf,opb_inf,opa_dn,opb_dn);

  input  clk;
  input  [30:0] opa,opb;
  output inf,ind,qnan,snan,opa_nan,opb_nan;
  output opa_00,opb_00;
  output opa_inf,opb_inf;
  output opa_dn;
  output opb_dn;
  wire [7:0] expa,expb;
  wire [22:0] fracta,fractb;
  reg  expa_ff,infa_f_r,qnan_r_a,snan_r_a;
  reg  expb_ff,infb_f_r,qnan_r_b,snan_r_b;
  reg  inf,ind,qnan,snan;
  reg  opa_nan,opb_nan;
  reg  expa_00,expb_00,fracta_00,fractb_00;
  reg  opa_00,opb_00;
  reg  opa_inf,opb_inf;
  reg  opa_dn,opb_dn;

  assign expa = opa[30:23];
  assign expb = opb[30:23];
  assign fracta = opa[22:0];
  assign fractb = opb[22:0];
  
  always @(posedge clk)  expa_ff <= &expa;
  
  always @(posedge clk)  expb_ff <= &expb;
  
  always @(posedge clk)  infa_f_r <= !|fracta;
  
  always @(posedge clk)  infb_f_r <= !|fractb;
  
  always @(posedge clk)  qnan_r_a <= fracta[22];
  
  always @(posedge clk)
      snan_r_a <= !fracta[22] & |fracta[21:0];
  
  always @(posedge clk)  qnan_r_b <= fractb[22];
  
  always @(posedge clk)
      snan_r_b <= |fractb[21:0] & !fractb[22];
  
  always @(posedge clk)
      ind <= infa_f_r & ((expb_ff & expa_ff) & infb_f_r);
  
  always @(posedge clk)
      inf <= ((expa_ff & (infa_f_r & expb_ff)) | (expb_ff & infb_f_r)) | (expa_ff & infa_f_r);
  
  always @(posedge clk)
      qnan <= ((qnan_r_a & expb_ff) | (((((qnan_r_b | qnan_r_a) & expa_ff) & expb_ff) | (expb_ff & qnan_r_b)) | (qnan_r_a & ((((expb_ff | qnan_r_a) & expa_ff) | (((qnan_r_b & (expb_ff | qnan_r_a)) & expa_ff) | expb_ff)) & qnan_r_a)))) & (qnan_r_b | expa_ff);
  
  always @(posedge clk)
      snan <= ((((snan_r_b & expa_ff) & snan_r_a) | ((snan_r_a & expa_ff) & expb_ff)) | (snan_r_b & expb_ff)) | ((snan_r_a & expa_ff) & ((snan_r_b | snan_r_a) & expa_ff));
  
  always @(posedge clk)
      opa_nan <= |fracta[22:0] & &expa;
  
  always @(posedge clk)
      opb_nan <= |fractb[22:0] & &expb;
  
  always @(posedge clk)
      opa_inf <= expa_ff & infa_f_r;
  
  always @(posedge clk)
      opb_inf <= expb_ff & infb_f_r;
  
  always @(posedge clk)  expa_00 <= !|expa;
  
  always @(posedge clk)  expb_00 <= !|expb;
  
  always @(posedge clk)  fracta_00 <= !|fracta;
  
  always @(posedge clk)  fractb_00 <= !|fractb;
  
  always @(posedge clk)
      opa_00 <= expa_00 & fracta_00;
  
  always @(posedge clk)
      opb_00 <= fractb_00 & expb_00;
  
  always @(posedge clk)  opa_dn <= expa_00;
  
  always @(posedge clk)  opb_dn <= expb_00;
endmodule

