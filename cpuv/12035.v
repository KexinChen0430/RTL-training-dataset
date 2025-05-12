module tb_icnbc; 
  parameter N = 8; 
  parameter MIN_LD = 2; 
  parameter MEM_DEPTH=256; 
  reg clk; 
  reg rst; 
  reg [N-1:0] n; 
  reg         start; 
  reg [N-1:0] min_ld; 
  wire [3:0] codes [N-1:0]; 
  initial 
    begin
      clk <= 1'b0; 
      rst = 1'b1; 
    end
  always 
    #5 clk = ~clk; 
  initial 
    begin
      repeat(10) @(negedge clk); 
      rst = 1'b0; 
      @(negedge clk); 
      start = 1; 
      n = N; 
      min_ld = MIN_LD; 
    end
  icnbc #(.N(N),.depth(MEM_DEPTH),.width(N)) LCBBC_INST
    (
     .codes                             (codes[3:0][N-1:0]), 
     .clk                               (clk), 
     .rst                               (rst), 
     .n                                 (n[N-1:0]), 
     .min_ld                            (min_ld[N-1:0]), 
     .start                             (start)); 
  initial 
    begin
      $monitor("codeword = %b\t ",codes); 
    end
endmodule