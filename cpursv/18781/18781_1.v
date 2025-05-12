
module gt32b;

  real  rlval;
  reg  rval;
  reg  aval[1:0];
  reg  [7:0] psval;

  
  initial  
  begin
    $timeformat(-12,0," ps",16);
    #1 ;
    $display("dl:gt32b- %t",$realtime);
    rlval <= #1 1.;
    rval <= #2 1'b1;
    aval[0] <= #3 1'b0;
    psval[1] <= #4 1'b1;
  end
  
  always @(rlval)
      begin
        $display("rl:gt32b- %t",$realtime);
      end
  
  always @(rval)
      begin
        $display("rg:gt32b- %t",$realtime);
      end
  
  always @(aval[0:0])
      begin
        $display("ar:gt32b- %t",$realtime);
      end
  
  always @(psval)
      begin
        $display("ps:gt32b- %t",$realtime);
      end
endmodule

