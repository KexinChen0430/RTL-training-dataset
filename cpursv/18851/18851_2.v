
module test;

  reg  [3:0] val1;
  reg  [3:0] val2;

  
  initial  
  begin
    val2 = 0;
    for (val1 = 0; val1 <= 4'ha; val1 = val1+1)
        begin
          val2 = val2+1;
        end
    if (val2 === 4'hb) 
      $display(PASSED);
    else 
      begin
        $display("FAILED val2 s/b 4'ha, but is %h",val2);
      end
  end
endmodule

