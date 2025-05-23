
module test;

  reg   fail = 1'b0;
  reg  [3:0]  in = 4'b0;
  wire [3:0]  bus = in;
  wire [3:0]  val = bus;

  
  initial  
  begin
    #1 
      if (val !== 4'b0) 
        begin
          $display("FAILED: initial value, got %b, expected 0000.",
                   val);
          fail = 1'b1;
        end
        

    #1 force bus[0] = 1'b1;
    #1 in[0] = 1'bz;
    #1 
      if (val !== 4'b0001) 
        begin
          $display("FAILED: force of bus[0], got %b, expected 0001.",
                   val);
          fail = 1'b1;
        end
        

    #1 force bus[3:2] = 2'b11;
    #1 
      if (val !== 4'b1101) 
        begin
          $display("FAILED: force of bus[3:2], got %b, expected 1101.",
                   val);
          fail = 1'b1;
        end
        

    #1 in[1] = 1'bz;
    #1 
      if (val !== 4'b11z1) 
        begin
          $display("FAILED: assignment of bus[1], got %b, expected 11z1.",
                   val);
          fail = 1'b1;
        end
        

    #1 in[1] = 1'b0;
    #1 release bus[0];
    #1 
      if (val !== 4'b110z) 
        begin
          $display("FAILED: release of bus[0], got %b, expected 110z.",
                   val);
          fail = 1'b1;
        end
        

    #1 release bus[3:2];
    #1 
      if (val !== 4'b000z) 
        begin
          $display("FAILED: release of bus[3:2], got %b, expected 000z.",
                   val);
          fail = 1'b1;
        end
        

    #1 force bus[2:1] = 2'bx1;
    #1 
      if (val !== 4'b0x1z) 
        begin
          $display("FAILED: force of bus[2:1], got %b, expected 0x1z.",
                   val);
          fail = 1'b1;
        end
        

    if (!fail) 
      $display(PASSED);
      
  end
endmodule

