
module m2;

  parameter  PAR2 = 10;

  
  initial  
  begin
    $display("%x",PAR2);
    if (PAR2 !== 2) 
      $stop;
      
  end
endmodule

