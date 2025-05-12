
module mnooverride;

  localparam  LOC = 13;
  parameter  PAR = 10;

  
  initial  
  begin
    $display("%x %x",LOC,PAR);
    if (LOC !== 13) 
      $stop;
      
    if (PAR !== 10) 
      $stop;
      
  end
endmodule

