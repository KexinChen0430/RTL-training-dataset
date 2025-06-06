
module check  #(parameter  HW = 4)
  (input  [HW<<1-1:0] x,
   input  y);

  wire  yi = ^x;

  
  always @(y or yi)
      begin
        #1 ;
        if (y !== yi) 
          begin
            $display(ERROR);
            $finish;
          end
          
      end
endmodule

