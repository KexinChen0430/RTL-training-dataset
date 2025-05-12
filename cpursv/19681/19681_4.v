
module main;

  wire [3:0] a,b,c;

  assign a = 4'd5,
         b = 4'd8,
         c = 4'd12;
  
  initial  
  begin
    #1 ;
    if ((c == 4'd12) && (b === 4'd8) && (a === 4'd5)) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

