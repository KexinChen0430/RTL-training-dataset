
module main;

  reg  globvar;
  wire [15:0] out;
  reg  [15:0] a,b,rslt;
  reg  error;

  nor foo[15:0](out,a,b);
  
  always @(a or b)  rslt = ~(a | b);
  
  initial  
  begin
    error = 0;
    #1 ;
    for (a = 16'h1; a != 16'h8000; a = a*2)
        begin
          for (b = 16'h8000; b !== 16'h0; b = b>>1)
              begin
                #1 ;
                if (out !== rslt) 
                  begin
                    $display("FAILED - GA NOR a=%h,b=%h,expct=%h - rcvd=%h",
                             a,b,rslt,out);
                    error = 1;
                  end
                  
              end
        end
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

