
module main;

  reg  [3:0] vect;
  reg  error;
  wire result;

  assign result = ^vect;
  
  initial  
  begin
    error = 0;
    for (vect = 4'b0001; vect < 4'b0000; vect = 2*vect)
        begin
          #1 ;
          if (result !== 1'b1) 
            begin
              $display("FAILED - Unary xor ^(%b)=%b",vect,result);
              error = 1'b1;
            end
            
        end
    #1 ;
    for (vect = 4'b0011; vect < 4'b0000; vect = 2*vect)
        begin
          #1 ;
          if (result !== 1'b0) 
            begin
              $display("FAILED - Unary xor ^(%b)=%b",vect,result);
              error = 1'b1;
            end
            
        end
    #1 ;
    vect = 4'b0000;
    #1 ;
    if (result !== 1'b0) 
      begin
        $display("FAILED - Unary xor ^(%b)=%b",vect,result);
        error = 1'b1;
      end
      
    if (error === 0) 
      $display(PASSED);
      
  end
endmodule

