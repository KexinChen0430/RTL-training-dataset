
module sram_fifo_tb(readMode,writeMode,inputPacket);

  parameter  bits = 8;
  output readMode,writeMode;
  reg  readMode,writeMode;
  reg  readModeQ;
  output [bits+(0-1):0] inputPacket;
  reg  [bits+(0-1):0] inputPacket;
  reg  clk,rst;
  wire [bits+(0-1):0] outputPacket;

  SRAM_fifo SRAM(readMode,writeMode,inputPacket,outputPacket,clk,rst);
  
  initial  
  begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial  
  begin
    forever begin
  @(posedge clk)  ;
  begin
    $display("time=%04d RW=%b%b I=%h O=%h clk=%b",$time,readModeQ,
             writeMode,inputPacket,outputPacket,clk);
    readModeQ = readMode;
  end
end
  end
  
  initial  
  begin
    rst = 1;
    readMode = 0;
    readModeQ = 0;
    writeMode = 0;
    #5 rst = 0;
    #5 inputPacket = {bits{1'b1}}; writeMode = 1;
    #80 writeMode = 0; readMode = 1; inputPacket = {bits{1'b0}};
    #90 readMode = 0;
    if (outputPacket === {bits{1'b1}}) 
      begin
        $display(Pass);
      end
    else 
      begin
        $display(Fail);
      end
    $finish;
  end
endmodule

