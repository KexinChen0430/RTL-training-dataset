
module main;

  real  x,y;

  
  initial  
  begin
    $monitor("%t: x=%f, y=%f",$time,x,y);
    #1 x = 1.;
    #1 y = 2.;
    #1 x = 1.5;
    #1 y = 5.1;
    #1 $finish;
  end
endmodule

