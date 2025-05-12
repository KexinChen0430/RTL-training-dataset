module shift_fifo_tb (
    readMode,  
    writeMode, 
    inputData  
  );
  output readMode, writeMode, inputData;
  reg readMode, writeMode, inputData;
  wire outputData;
  reg clk, rst;
  shift_fifo fifoInstance (readMode, writeMode,
                           inputData, outputData, clk, rst);
  initial
  begin
    clk=0;
    forever #5 clk=~clk;
  end
  initial
  begin
    forever begin
      @(posedge clk); 
        $display("time=%04d RW=%b%b IO=%b%b clk=%b", $time,
            readMode, writeMode, inputData, outputData, clk);
    end
  end
  initial
  begin
    readMode = 0;
    writeMode = 0;
    inputData = 0;
    #5 rst = 1;
    #5 rst = 0;
    #5 inputData = 1; writeMode = 1;
    #80 readMode = 1; writeMode = 0; inputData = 0;
    #80 readMode = 0;
    if (1'b1 === outputData) begin 
      $display("Pass");
    end else begin
      $display("Fail");
    end
    $finish;
  end
endmodule