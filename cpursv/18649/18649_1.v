
module main;

  reg  C;
  reg  [1:0] in;
  wire [1:0] out;

  DFF u[1:0](out,in,C);
  
  initial  
  begin
    C <= 0;
    in <= 2'b00;
    #10 C <= 1;
    #10 
      if (out !== 2'b00) 
        begin
          $display("FAILED -- out=%b, in=%b",out,in);
          $finish;
        end
        

    C <= 0;
    in <= 2'b10;
    #10 C <= 1;
    #10 
      if (out !== 2'b10) 
        begin
          $display("FAILED -- out=%b, in=%b",out,in);
          $finish;
        end
        

    C <= 0;
    in <= 2'b01;
    #10 C <= 1;
    #10 
      if (out !== 2'b01) 
        begin
          $display("FAILED -- out=%b, in=%b",out,in);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

