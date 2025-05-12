
module main;

  
  initial  
  begin
    
    fork : fork_label
        #100 disable fork_label;
        #200 begin
          $display("FAILED -- shouldn't get here");
          $finish;
        end
    join

    $display(PASSED);
  end
endmodule

