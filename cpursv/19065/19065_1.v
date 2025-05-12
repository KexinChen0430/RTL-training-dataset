
module main;

  integer mem[0:1];

  
  initial  
  begin
    if (mem[0] !== 32'hxxxx) 
      begin
        $display("FAILED -- mem[0] == %b",mem[0]);
        $finish;
      end
      
    if (mem[1] !== 32'hxxxx) 
      begin
        $display("FAILED -- mem[1] == %b",mem[1]);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

