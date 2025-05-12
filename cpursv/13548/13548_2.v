
module techlib_assert(A,EN);

  input  A,EN;

  
  always @* 
      begin
        if ((A !== 1'b1) && (EN === 1'b1)) 
          begin
            $display("Assertion %m failed!");
            $stop;
          end
          
      end
endmodule

