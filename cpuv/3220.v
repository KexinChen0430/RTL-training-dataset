module fifo(consumer_data,producer_data, consumer_req);
  input consumer_req; 
  input producer_data; 
  output consumer_data; 
  reg [3:0] consumer_data; 
  reg [3:0] producer_data;
  reg consumer_req;
  int i;
  int j;
  int last; 
  int start; 
  int diff; 
  int last_s; 
  int start_s; 
  reg [3:0] queue [9:0];
  initial
    begin
      assign last_s = last % 10;
      assign start_s = start % 10;
      assign diff = last - start;
      #30for(j=0;j<10;j++)
        begin
        end
    end
  always @ (producer_data)
    if((diff < 10)) 
      begin
        queue[last_s] = producer_data;
        #0 last = last +1;
      end
    else begin
      $finish;
    end
  always @(consumer_req)
    begin
      if(consumer_req == 1) 
        begin
          if(diff != 0) 
            begin
              consumer_data = queue[start_s];
              #0 start = start +1;
            end
        end
    end
endmodule