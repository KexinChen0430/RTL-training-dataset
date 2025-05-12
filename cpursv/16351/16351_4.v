
module arr;

  parameter  LENGTH = 1;
  reg  [(-1)+LENGTH:0] sig;
  reg  [(-1)+LENGTH:0] rfr;
  reg  check;
  reg  verbose;

  
  always @(posedge check)
      begin
        if (verbose) 
          $display("%m : %x %x",sig,rfr);
          
        if (check && (sig != rfr)) 
          $stop;
          
        check <= 0;
      end
endmodule

