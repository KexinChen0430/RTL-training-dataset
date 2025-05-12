
module tb_lcbbc;

  parameter  N = 8;
  parameter  MIN_HD = 1<<1;
  parameter  MEM_DEPTH = 256;
  reg  clk;
  reg  rst;
  reg  [N+(-1):0] n;
  reg  start;
  reg  [N+(-1):0] min_hd;
  wire [N+(-1):0] codes;

  
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
  lcbbc #(.N(N),.depth(MEM_DEPTH),.width(N)) LCBBC_INST(.codes(codes[N+(-1):0]),
                                                        .clk(clk),.rst(rst),
                                                        .n(n[N+(-1):0]),.min_hd(min_hd[N+(-1):0]),
                                                        .start(start));
  
  initial  
  begin
    $monitor("codeword = %b\t ",codes);
  end
endmodule

