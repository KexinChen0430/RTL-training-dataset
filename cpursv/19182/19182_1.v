
module main;

  reg  [3:0] vect;
  reg  error;
  reg  result;

  
  initial  
  begin
    error = 0;
    for (vect = 4'b0001; vect < 4'b1111; vect = 1+vect)
        begin
          result = ~|vect;
          if (result !== 1'b0) 
            begin
              $display("FAILED - Unary nor ~|(%b)=%b",vect,result);
              error = 1'b1;
            end
            
        end
    #1 ;
    vect = 4'b0000;
    result = ~|vect;
    if (result !== 1'b1) 
      begin
        $display("FAILED - Unary nor |~(%b)=%b",vect,result);
        error = 1'b1;
      end
      
    if (error === 0) 
      $display(PASSED);
      
  end
endmodule

