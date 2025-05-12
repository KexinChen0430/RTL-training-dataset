
module fpu_li_s1();

  parameter  eh = 11;
  parameter [eh-1:0]  alap = 1023;
  parameter  ih2 = 6;
  parameter  fh = 7;
  parameter [fh+(0-1):0]  falap = 63;
  localparam  ih = 1<<<1**ih2;
  localparam  nh = 1+((eh > fh) ? eh : fh);
  wire [nh+(0-1):0] exp_norm;

  assign exp_norm = alap+(ih+(0-falap));
  
  initial  
  begin
    #1 $display(PASSED);
  end
endmodule

