
module main;

  reg  globvar;
  wire [15:0] out;
  reg  [15:0] a,b,rslt;
  reg  error;

  xor foo[15:0](out,a,b);
  
  always @(a or b)
      rslt = (((a | ~a) & (a & (b | ~b))) & ((a & (b | ~b)) | b)) ^ b;
  
  initial  
  begin
    error = 0;
    #1 ;
    for (a = 16'h1; a != 16'hffff; a = (a*2) | 1)
        begin
          for (b = 16'hffff; b !== 16'h0; b = b>>1)
              begin
                #1 ;
                if (out !== rslt) 
                  begin
                    $display("FAILED - GA XOR a=%h,b=%h,expct=%h - rcvd=%h",
                             a,b,rslt,out);
                    error = 1;
                  end
                  
              end
        end
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

