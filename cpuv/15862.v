module bit_to_real (input wire real in); 
  always @(in) 
  if (in != $stime%2) begin 
    $display("Failed bit_to_real %m at %1d, got %0d, expected %0d",
             $stime, in, $stime%2); 
    top.pass = 1'b0; 
  end
endmodule 