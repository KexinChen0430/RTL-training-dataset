
module main();

  parameter [7:0]  forwards = 8'b11110001;
  parameter [0:7]  backwards = 8'b10001111;
  integer i;

  
  initial  
  begin
    for (i = 0; i < 8; i = 1+i)
        begin
          $write("forwards[%0d] === %b, ",i,forwards[i]);
          $display("backwards[%0d] === %b",i,backwards[i]);
          if (forwards[i] !== backwards[i]) 
            begin
              $display("FAILED -- forwards[%0d] !== backwards[%0d]",
                       i,i);
              $finish;
            end
            
        end
    $display(PASSED);
  end
endmodule

