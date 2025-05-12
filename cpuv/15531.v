module m2();
  m1 m1inst();
  task hello1;
    begin
      $display("hello1 from m2");
    end
  endtask
  task hello2;
    begin
      $display("hello2 from m2");
    end
  endtask
  task hello3;
    begin
      $display("hello3 from m2");
    end
  endtask
  task hello4;
    begin
      $display("hello4 from m2");
    end
  endtask
endmodule