
module techlib_equiv(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((A !== B) && (A !== 1'bx)) ? 1'bx : A;
  
  always @* 
      begin
        if ((A !== B) && (A !== 1'bx)) 
          begin
            $display("Equivalence failed!");
            $stop;
          end
          
      end
endmodule

