
module test;

  reg  [0:32] big_reg;
  reg  [0:32] my_mem[0:16];
  reg  event_trigger;

  
  initial  
  begin
    #10 $display("!!!VERIGLOG: big_reg=%h",big_reg);
    $display("            my_mem[1]=%h",my_mem[1]);
    event_trigger = 1;
    #10 big_reg = 33'h1_2345_6789; my_mem[1] = 33'h1_5432_9876;
    #10 $display("!!!VERIGLOG: big_reg=%h",big_reg);
    $display("            my_mem[1]=%h",my_mem[1]);
    event_trigger = !event_trigger;
    #10 $finish(0);
  end
endmodule

