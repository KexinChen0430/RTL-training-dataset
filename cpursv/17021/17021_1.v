
module main();

  
  initial  
  begin
    $display("|%b|",10'b11);
    $display("|%0b|",10'b11);
    $display("|%b|",10'b0);
    $display("|%0b|",10'b0);
    $finish(0);
  end
endmodule

