
module tester(output reg clk,
              output reg [7:0] data);

  
  initial  
  begin
    clk <= 1;
    repeat (100000000)
      begin
        #1 clk = ~clk;
      end
  end
  reg  [7:0] datas[0:32];

  
  initial  
  begin
    datas[0] = 8'h0A;
    datas[1] = 8'h1A;
    datas[31] = 8'h4D;
  end
  
  initial  
  begin
    data <= datas[0];
    data <= datas[1];
    data <= datas[31];
  end
endmodule

