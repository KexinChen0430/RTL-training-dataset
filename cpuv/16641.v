module same; 
  timeunit 1ps; 
  timeprecision 1ps; 
  function logic check_time; 
    realtime result; 
    check_time = 1'b1; 
    result = 1ns; 
    if (result != 1000.0) begin 
      $display("Failed-same: Expected 1ns to be rounded to 1000.0, got %f", result); 
      check_time = 1'b0; 
    end
    result = 1ps; 
    if (result != 1.0) begin 
      $display("Failed-same: Expected 1ps to be rounded to 1.0, got %f", result); 
      check_time = 1'b0; 
    end
    result = 0.5ps; 
    if (result != 1.0) begin 
      $display("Failed-same: Expected 0.5ps to be rounded to 1.0, got %f", result); 
      check_time = 1'b0; 
    end
    result = 0.499ps; 
    if (result != 0.0) begin 
      $display("Failed-same: Expected 0.49ps to be rounded to 0.0, got %f", result); 
      check_time = 1'b0; 
    end
  endfunction 
endmodule 