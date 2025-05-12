
module main;

  reg  [7:0] a;
  reg  b;
  reg  c;
  reg  error;

  
  initial  
  begin
    #1 ;
    error = 0;
    for (a = 0; a <= 8'h1; a = 1+a)
        begin
          b = 0;
          #1 ;
          if (a) 
            begin
              if (!c) 
                begin
                  $display("FAILED - XOR a=%b,b=%b,c=%b",a,b,c);
                  error = 1;
                end
                
            end
            
          if (!a) 
            begin
              if (c) 
                begin
                  $display("FAILED - XOR a=%b,b=%b,c=%b",a,b,c);
                  error = 1;
                end
                
            end
            
          b = 1;
          #1 ;
          if (!a) 
            begin
              if (!c) 
                begin
                  $display("FAILED - XOR a=%b,b=%b,c=%b",a,b,c);
                  error = 1;
                end
                
            end
            
          if (a) 
            begin
              if (c) 
                begin
                  $display("FAILED - XOR a=%b,b=%b,c=%b",a,b,c);
                  error = 1;
                end
                
            end
            
        end
    if (!error) 
      $display(PASSED);
      
  end
  
  always @(a or b)
      c <= (((~b & ((b & (a & (b | ~b))) & (b | ~b))) | ~((b & (a & (b | ~b))) & (b | ~b))) & ((~b & ((b & (a & (b | ~b))) & (b | ~b))) | b)) ^ (((b & a) ^ a) & (b | ((b & a) ^ a)));
endmodule

