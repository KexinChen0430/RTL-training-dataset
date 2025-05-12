module foo
  (
  result_0, result_1,
  clk, reset, enable_a
  );
  input                 clk;
  input                 reset;
  input                 enable_a;
  output                result_0;
  output                result_1;
  wire                  enable_0, enable_1;
  assign                enable_0 = 1'd1;
  assign                enable_1 = enable_a;
  bar bar0
    (
     .result                            (result_0),              
     .clk                               (clk),                   
     .enable                            (enable_0),              
     .reset                             (reset));                
  bar bar1
    (
     .result                            (result_1),              
     .clk                               (clk),                   
     .enable                            (enable_1),              
     .reset                             (reset));                
endmodule