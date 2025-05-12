
module fpu_li_s1();

  parameter  eh = 11;
  parameter [(0-1)+eh:0]  alap = 1023;
  parameter  ih2 = 6;
  parameter  fh = 7;
  parameter [(0-1)+fh:0]  falap = 63;
  localparam  ih = 1<<ih2;
  localparam  nh = ((eh > fh) ? eh : fh)+1;
  wire [nh-1:0] exp_norm;

  assign exp_norm = alap+((0-falap)+ih);
  
  initial  
  begin
    #1 $display(PASSED);
  end
endmodule

