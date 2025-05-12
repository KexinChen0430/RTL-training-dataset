
module stim;

  reg  a;

  
  initial  
  begin
    a = 0;
    #1 a = 1;
    #1 a = 0;
  end
  
  initial  
  begin
    $monitor("Time = %0d a = %b",$time,a);
  end
endmodule

