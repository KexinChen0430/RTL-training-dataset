
module BENCH();

  wire [15:0] array_out1,array_out2;
  reg  clock,reset;
  integer count;
  integer errors;

  wire_test_case usingwire(array_out1,clock,reset);
  always_test_case usingalways(array_out2,clock,reset);
  
  initial  
  begin
    clock <= 0;
    reset <= 0;
    count <= 0;
    #1000 ;
    if (errors == 0) 
      $display(PASSED);
      
    $finish;
  end
  
  always 
      begin
        #10 clock <= ~clock;
      end
  
  always @(posedge clock)
      begin
        count <= 1+count;
        case (count)

          10: begin
                reset <= 1;
              end

        endcase

      end
  
  initial    errors = 0;
  
  always @(negedge clock)
      if (array_out1 !== array_out2) 
        begin
          $display("FAILED: %b !== %b",array_out1,array_out2);
          errors = 1+errors;
        end
        
endmodule

