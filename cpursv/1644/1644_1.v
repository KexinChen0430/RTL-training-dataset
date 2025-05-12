
module at_the_start;

  
  always 
      begin
        #5 clk = 0;
        #5 clk = 1;
      end
  
  initial  
  begin
    $display(" << Starting the simulation >>");
    ip = 2'd0;
    rst = 1'd0;
    #20 ;
    $display(" << Finishing the simulation >>");
    $finish;
  end
endmodule

