
module main;

  reg  [3:0] vect;
  reg  error;
  wire result;

  assign result = &vect;
  
  initial  
  begin
    error = 0;
    for (vect = 4'b000; vect < 4'b1111; vect = vect+1)
        begin
          #1 ;
          if (result !== 1'b0) 
            begin
              $display("FAILED - Unary and &(%b)=%b",vect,result);
              error = 1'b1;
            end
            
        end
    #1 ;
    vect = 4'b1111;
    #1 ;
    if (result !== 1'b1) 
      begin
        $display("FAILED - Unary and &(%b)=%b",vect,result);
        error = 1'b1;
      end
      
    if (error === 0) 
      $display(PASSED);
      
  end
endmodule

