
module shift_fifo(readMode,writeMode,inputBit,outputBit,clk,rst);

  input  readMode,writeMode,clk,rst;
  input  inputBit;
  output outputBit;
  reg  outputBit;
  reg  [7:0] curData;
  reg  [2:0] topPtr;

  
  always @(posedge clk or posedge rst)
      if (rst) 
        begin
          topPtr <= 3'h0;
          curData <= 8'h00;
        end
      else 
        begin
          if (readMode) 
            begin
              {curData,outputBit} <= {1'b0,curData};
              topPtr <= topPtr-1;
            end
          else if (writeMode) 
            begin
              curData[topPtr] <= inputBit;
              topPtr <= topPtr+1;
            end
            
        end
endmodule

