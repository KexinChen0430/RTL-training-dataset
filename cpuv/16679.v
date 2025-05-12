module top; 
  reg passed; 
  reg pevt; 
  reg evt; 
  reg pedge; 
  reg nedge; 
  initial begin 
    passed = 1'b1; 
    #1; 
    {pedge, nedge} = 2'b01; 
    evt = 1'b0; 
    #1; 
    pevt = evt; 
    {pedge, nedge} = 2'b10; 
    evt = 1'bx; 
  always @(posedge evt) begin 
    if (!pedge) begin 
      $display("Error: posedge detected for %b -> %b", pevt, evt); 
      passed = 1'b0; 
    end
  end
  always @(negedge evt) begin 
    if (!nedge) begin 
      $display("Error: negedge detected for %b -> %b", pevt, evt); 
      passed = 1'b0; 
    end
  end
  always @(edge evt) begin 
    if (!nedge && !pedge) begin 
      $display("Error: edge detected for %b -> %b", pevt, evt); 
      passed = 1'b0; 
    end
  end
  always @(evt) 
    $display("Checking the %b -> %b event", pevt, evt); 
endmodule 