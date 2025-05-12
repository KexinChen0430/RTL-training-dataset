module main(); 
initial 
  begin 
    $display("4'bxxxx = %d", 4'bxxxx); 
    $display("4'bzzxx = %d", 4'bzzxx); 
    $display("4'bzzzz = %d", 4'bzzzz); 
    $display("4'b00zz = %d", 4'b00zz); 
    $display("4'b0000 = %d", 4'b0000); 
    $display("4'b0011 = %d", 4'b0011); 
    $finish(0); 
  end 
endmodule 