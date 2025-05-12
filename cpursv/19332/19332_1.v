
module main;

  reg  [3:0] mem[0:1];

  
  initial  
  begin
    if (mem[0] !== 4'bxxxx) 
      begin
        $display("FAILED -- mem[0] == %b",mem[0]);
        $finish;
      end
      
    if (mem[1] !== 4'bxxxx) 
      begin
        $display("FAILED -- mem[1] == %b",mem[1]);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

