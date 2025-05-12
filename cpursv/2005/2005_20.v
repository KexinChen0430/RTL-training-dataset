
module axi_slave  #(parameter 
       ACCEPTANCE  = 3,
       MIN_LATENCY = 16,
       MAX_LATENCY = 32)
  (input  clk,
   input  reset,
   input  valid,
   output ready,
   input  [31:0] addr,
   input  [7:0] len,
   input  [1<<1:0] size,
   input  [1:0] burst,
   input  [1<<1:0] prot,
   input  [3:0] cache,
   output beat_stb,
   input  beat_ack,
   output [31:0] beat_addr,
   output beat_last);

  reg  [31:0]  timestamp = 'h00;

  
  always @(posedge clk)
      begin
        if (reset == 1'b1) 
          begin
            timestamp <= 'h00;
          end
        else 
          begin
            timestamp <= 1'b1+timestamp;
          end
      end
  reg  [(8+32)+(32+(-1)):0] req_fifo[0:15];

  reg  [3:0]  req_fifo_rd = 'h00;

  reg  [3:0]  req_fifo_wr = 'h00;

  wire [3:0]  req_fifo_level = req_fifo_wr-req_fifo_rd;

  assign ready = req_fifo_level < ACCEPTANCE;
  
  always @(posedge clk)
      begin
        if (reset == 1'b1) 
          begin
            req_fifo_wr <= 'h00;
          end
        else 
          begin
            if ((valid == 1'b1) && (ready == 1'b1)) 
              begin
                req_fifo[req_fifo_wr][71:40] <= (timestamp+MIN_LATENCY)+({$random}%(1+(MAX_LATENCY-MIN_LATENCY)));
                req_fifo[req_fifo_wr][39:0] <= {addr,len};
                req_fifo_wr <= req_fifo_wr+1'b1;
              end
              
          end
      end
  reg  [7:0]  beat_counter = 'h00;

  assign beat_stb = (timestamp > req_fifo[req_fifo_rd][71:40]) && 
                    (req_fifo_level != 0);
  assign beat_last = beat_stb ? (beat_counter == req_fifo[req_fifo_rd][0 +: 8]) : 1'b0;
  assign beat_addr = (beat_counter*4)+req_fifo[req_fifo_rd][8 +: 32];
  
  always @(posedge clk)
      begin
        if (reset == 1'b1) 
          begin
            beat_counter <= 'h00;
            req_fifo_rd <= 'h00;
          end
        else 
          begin
            if (beat_ack == 1'b1) 
              begin
                if (beat_last == 1'b1) 
                  begin
                    beat_counter <= 'h00;
                    req_fifo_rd <= 1'b1+req_fifo_rd;
                  end
                else 
                  begin
                    beat_counter <= beat_counter+1'b1;
                  end
              end
              
          end
      end
endmodule

