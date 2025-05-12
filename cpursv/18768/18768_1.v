
module ls32b;

  real  rlval;
  reg  rval;
  reg  aval[1:0];
  reg  [7:0] psval;

  
  initial  
  begin
    #1 ;
    $display("dl:ls32b- %t",$realtime);
    rlval <= #1 1.;
    rval <= #2 1'b1;
    aval[0] <= #3 1'b0;
    psval[1] <= #4 1'b1;
  end
  
  always @(rlval)
      begin
        $display("rl:ls32b- %t",$realtime);
      end
  
  always @(rval)
      begin
        $display("rg:ls32b- %t",$realtime);
      end
  
  always @(aval[0:0])
      begin
        $display("ar:ls32b- %t",$realtime);
      end
  
  always @(psval)
      begin
        $display("ps:ls32b- %t",$realtime);
      end
endmodule

