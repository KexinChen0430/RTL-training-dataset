module main ; 
reg [3:0] value1 ; 
always begin : block_id
          #4 ; 
          value1 = 1; 
          $finish ; 
      end
initial
  begin
    value1 = 0; 
    #5; 
    if(value1 === 1'b0)
      $display("PASSED"); 
    else
      $display("FAILED - always3.1.9D always #1 disable block_id");
    #1; 
    $finish ; 
  end
always #3 disable block_id ; 
endmodule 