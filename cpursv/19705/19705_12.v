
module speak(x1,x2,x3);

  input  [6:0] x1,x2,x3;

  
  always 
      #100 $display("%d: x1=%d, x2=%d, x3=%d",$time,x1,x2,x3);
  integer errors;

  
  initial  
  begin
    errors = 0;
    #100 
      if ((x3 !== 7'b0) || ((x2 !== 7'b0) || (x1 !== 7'b0))) 
        begin
          errors = errors+1;
          $display(FAILED);
        end
        

    #100 
      if ((x3 !== 7'b0) || ((x2 !== 7'b0) || (x1 !== 7'b1))) 
        begin
          errors = errors+1;
          $display(FAILED);
        end
        

    #100 
      if ((x2 !== 7'b1) || (x3 !== 7'b0) || (x1 !== 7'b0)) 
        begin
          errors = errors+1;
          $display(FAILED);
        end
        

    #100 
      if ((x1 !== 7'b0) || ((x2 !== 7'b0) || (x3 !== 7'b1))) 
        begin
          errors = errors+1;
          $display(FAILED);
        end
        

    if (errors === 0) 
      $display(PASSED);
      
  end
endmodule

