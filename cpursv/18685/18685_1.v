
module check(input  signed  [22:0] a,b,c);

  wire signed  [22:0] int_AB;

  assign int_AB = a+b;
  
  always @(a or b or int_AB or c)
      begin
        #1 ;
        if (int_AB !== c) 
          begin
            $display(ERROR);
            $finish;
          end
          
      end
endmodule

