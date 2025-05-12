module vec_to_real (input wire real in); 
  always @(in) 
    if (in != $stime) begin 
      $display("Failed vec_to_real %m at %1d, got %0d, expected %0d",
               $stime, in, $stime); 
      top.pass = 1'b0; 
    end
endmodule 