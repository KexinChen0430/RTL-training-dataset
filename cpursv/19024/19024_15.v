
module fpu_li_s1();

  parameter  eh = 11;
  parameter [eh-1:0]  alap = 1023;
  parameter  ih2 = 6;
  parameter  fh = 7;
  parameter [fh+(-1):0]  falap = 63;
  localparam  ih = 1<<<ih2;
  localparam  nh = 1+((eh > fh) ? eh : fh);
  wire [nh+(-1):0] exp_norm;

  assign exp_norm = ((-falap)+ih)+alap;
  
  initial  
  begin
    #1 $display(PASSED);
  end
endmodule

