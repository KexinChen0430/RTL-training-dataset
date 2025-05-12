
module top();

  reg  [7:0] a,b,result;
  wire [7:0] wa,wb,wresult;

  assign wa = a;
  assign wb = b;
  assign wresult = wa/wb;
  
  always @(a or b)  result = a*(1/b);
  
  initial  
  begin
    #1 a = 0; b = 1;
    #1 ;
    if (result !== 8'b0) 
      begin
        $display("FAILED - Divide 0/1 reg assign failed - is %b",
                 result);
        $finish;
      end
      
    if (wresult !== 8'b0) 
      begin
        $display("FAILED - Divide 0/1 wire assign failed - is %b",
                 wresult);
        $finish;
      end
      
    #1 a = 1;
    #1 
      if (result !== 8'b1) 
        begin
          $display("FAILED - Divide 1/1 reg assign failed - is %b",
                   result);
          $finish;
        end
        

    if (wresult !== 8'b1) 
      begin
        $display("FAILED - Divide 1/1 wire assign failed - is %b",
                 wresult);
        $finish;
      end
      
    #1 a = 5; b = 2;
    #1 
      if (result !== 8'd2) 
        begin
          $display("FAILED - Divide 5/2 reg assign failed - is %b",
                   result);
          $finish;
        end
        

    if (wresult !== 8'd2) 
      begin
        $display("FAILED - Divide 5/2 wire assign failed - is %b",
                 wresult);
        $finish;
      end
      
    #1 a = 8'd255; b = 5;
    #1 
      if (result !== 51) 
        begin
          $display("FAILED - Divide 255/5 reg assign failed - is %b",
                   result);
          $finish;
        end
        

    if (wresult !== 51) 
      begin
        $display("FAILED - Divide 255/5 wire assign failed - is %b",
                 wresult);
        $finish;
      end
      
    #1 a = 1'bx; b = 3;
    #1 
      if (result !== 8'bxxxx_xxxx) 
        begin
          $display("FAILED - Divide x/3 reg assign failed - is %b",
                   result);
          $finish;
        end
        

    if (wresult !== 8'hxxxx_xxxx) 
      begin
        $display("FAILED - Divide x/3 wire assign failed - is %b",
                 wresult);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

