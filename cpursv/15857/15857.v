
module real_to_bit(input  wire in);

  
  always @(in)
      if (in !== ($stime%2)) 
        begin
          $display("Failed real_to_bit %m at %1d, got %b, expected %2b",
                   $stime,in,$stime%2);
          top.pass = 1'b0;
        end
        
endmodule

