
module m();

  
  initial  
  begin
    #10 ;
    $display(FAILED);
    $finish;
  end
  
  task t;

    begin
      begin : wait_loop
        #1 ;
        while (1)
          begin
            #1 ;
            disable wait_loop;
          end
      end
    end
  endtask
  
  initial  
  begin
    t;
    $display(PASSED);
    $finish;
  end
endmodule

