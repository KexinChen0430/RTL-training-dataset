
module tb_lcbbc;

  parameter  N = 8;
  parameter  MIN_HD = 1<<1;
  parameter  MEM_DEPTH = 256;
  reg  clk;
  reg  rst;
  reg  [(0-1)+N:0] n;
  reg  start;
  reg  [(0-1)+N:0] min_hd;
  wire [(0-1)+N:0] codes;

  
  initial  
  begin
    clk <= 1'b0;
    rst = 1'b1;
  end
  
  always   #5 clk = ~clk;
  
  initial  
  begin
    repeat (10)
      @(negedge clk)  ;
    rst = 1'b0;
    @(negedge clk)  ;
    start = 1;
    n = N;
    min_hd = MIN_HD;
  end
  lcbbc #(.N(N),.depth(MEM_DEPTH),.width(N)) LCBBC_INST(.codes(codes[(0-1)+N:0]),
                                                        .clk(clk),.rst(rst),
                                                        .n(n[(0-1)+N:0]),.min_hd(min_hd[(0-1)+N:0]),
                                                        .start(start));
  
  initial  
  begin
    $monitor("codeword = %b\t ",codes);
  end
endmodule

