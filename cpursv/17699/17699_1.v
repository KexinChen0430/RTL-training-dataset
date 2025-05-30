
module top;

  reg  passed,in,expect;
  integer lp;
  wire  rand = &in;
  wire  ror = |in;
  wire  rxor = ^in;
  wire  rnand = ~&in;
  wire  rnor = ~|in;
  wire  rxnor = ~^in;

  
  initial  
  begin
    passed = 1'b1;
    for (lp = 0; lp < 3; lp = 1+lp)
        begin
          case (lp)

            0: {in,expect} = 2'b00;

            1: {in,expect} = 2'b11;

            2: {in,expect} = 2'bzx;

            3: {in,expect} = 2'bxx;

          endcase

          #1 ;
          if (rand !== expect) 
            begin
              $display("FAILED CA reduction & with input %b, expected %b, got %b",
                       in,expect,rand);
              passed = 1'b0;
            end
            
          if (ror !== expect) 
            begin
              $display("FAILED CA reduction | with input %b, expected %b, got %b",
                       in,expect,ror);
              passed = 1'b0;
            end
            
          if (rxor !== expect) 
            begin
              $display("FAILED CA reduction ^ with input %b, expected %b, got %b",
                       in,expect,rxor);
              passed = 1'b0;
            end
            
          if (rnand !== ~expect) 
            begin
              $display("FAILED CA reduction ~& with input %b, expected %b, got %b",
                       in,~expect,rnand);
              passed = 1'b0;
            end
            
          if (rnor !== ~expect) 
            begin
              $display("FAILED CA reduction ~| with input %b, expected %b, got %b",
                       in,~expect,rnor);
              passed = 1'b0;
            end
            
          if (rxnor !== ~expect) 
            begin
              $display("FAILED CA reduction ~^ with input %b, expected %b, got %b",
                       in,~expect,rxnor);
              passed = 1'b0;
            end
            
        end
    if (passed) 
      $display(PASSED);
      
  end
endmodule

