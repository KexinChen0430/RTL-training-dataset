
module test;

  reg  a,b,c,d;
  wire  ab = a & b;
  wire  abc = c | ab;
  wire  abcd = d & abc;

  
  initial  
  begin
    a = 0;
    b = 1;
    c = 0;
    d = 1;
    #1 ;
    a = 1;
    if (abcd === 1) 
      begin
        $display(PASSED);
        $finish;
      end
      
    $display("FAILED ab=%b, abc=%b, abcd=%b",ab,abc,abcd);
    #1 ;
    if (abcd === 1) 
      $display("abcd value changed late");
    else 
      $display("abcd value still wrong");
  end
endmodule

