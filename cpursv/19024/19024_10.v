
module fpu_li_s1();

  parameter  eh = 11;
  parameter [(-1)+eh:0]  alap = 1023;
  parameter  ih2 = 6;
  parameter  fh = 7;
  parameter [(-1)+fh:0]  falap = 63;
  localparam  ih = 1<<<ih2;
  localparam  nh = 1+((eh > fh) ? eh : fh);
  wire [(-1)+nh:0] exp_norm;

  assign exp_norm = ((0-falap)+alap)+ih;
  
  initial  
  begin
    #1 $display(PASSED);
  end
endmodule

