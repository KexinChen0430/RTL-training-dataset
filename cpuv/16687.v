module max; 
  timeunit 100s; 
  timeprecision 1fs; 
  function logic check_time; 
    realtime result; 
    check_time = 1'b1; 
    result = 1s; 
    if (result != 1e-2) begin 
      $display("Failed-max: Expected 1s to be rounded to 1.0e-2, got %f", result); 
      check_time = 1'b0; 
    end
    result = 0.5fs; 
    if (result != 1e-17) begin 
      $display("Failed-max: Expected 0.5fs to be rounded to 1.0e-17, got %f", result); 
      check_time = 1'b0; 
    end
    result = 0.499fs; 
    if (result != 0.0) begin 
      $display("Failed-max: Expected 0.49fs to be rounded to 0.0, got %f", result); 
      check_time = 1'b0; 
    end
  endfunction 
endmodule 