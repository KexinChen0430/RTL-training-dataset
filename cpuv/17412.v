module top; 
  reg pass = 1'b1; 
  reg clk = 0; 
  reg [7:0] result; 
  reg [3:0] bit; 
  always #10 clk = ~clk; 
  initial begin 
    result[bit] <= repeat(3) @(posedge clk) 1'b0; 
    if ($simtime != 0 || result !== 8'bx) begin 
      $display("Failed repeat(3) blocked at %0t, expected 8'hxx, got %h",
               $simtime, result);
      pass = 1'b0;
    end
    #51; 
    if (result !== 8'hxx) begin 
      $display("Failed repeat(3) at %0t, expected 8'hxx, got %h",
               $simtime, result);
      pass = 1'b0;
    end
    bit = 0; 
    result[bit] <= @(posedge clk) 4'h0; 
    @(result) 
    if ($simtime != 70 || result !== 8'bxxxxxxx0) begin 
      $display("Failed repeat(3) at %0t, expected 8'bxxxxxxx0, got %h",
               $simtime, result);
      pass = 1'b0;
    end
    if (pass) $display("PASSED"); 
    $finish; 
  end
endmodule 