
module main;

  parameter  offset = 7.;
  time  result;

  
  initial  
  begin
    #9 result = $time+offset; $display("result = %d",result);
    if (result !== 64'd16) 
      begin
        $display("FAILED -- incorrect result");
        $finish;
      end
      
    $display(PASSED);
    $finish;
  end
endmodule

