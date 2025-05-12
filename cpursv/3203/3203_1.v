
module producer(producer_data);

  output producer_data;
  reg  producer_iclk;
  reg  [3:0] producer_data;
  reg  [3:0]  i = 4'b0000;

  
  always @(producer_iclk)
      begin
        producer_data = 1+producer_data;
      end
  
  initial  
  begin
    producer_data = 0;
    producer_iclk = 0;
  end
  
  always 
      begin
        #5 producer_iclk = ~producer_iclk;
      end
endmodule

