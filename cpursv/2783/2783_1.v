
module arr;

  parameter  LENGTH = 1;
  reg  [(-1)+LENGTH:0] sig;
  reg  [(-1)+LENGTH:0] rfr;
  reg  check;
  reg  verbose;

  
  initial  
  begin
    sig = {LENGTH{1'b0}};
    rfr = {LENGTH{1'b0}};
  end
  
  always @(posedge check)
      begin
        if (verbose) 
          $display("%m : %x %x",sig,rfr);
          
        if ((sig != rfr) && check) 
          $stop;
          
        check <= 0;
      end
endmodule

