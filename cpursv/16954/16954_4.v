
module spi(input  reset,
           input  clk,
           output sen,
           output sclk,
           input  sdi,
           output sdo,
           input  read_1,
           input  write_1,
           input  [15:0] command_1,
           input  [15:0] wdata_1,
           output [15:0] rdata_1,
           output reg done_1,
           input  msb_first_1,
           input  [5:0] command_width_1,
           input  [5:0] data_width_1,
           input  [7:0] clkdiv_1);

  reg  [15:0] command,wdata,rdata;
  reg  done;

  
  always @(posedge clk)
      if (reset) done_1 <= #1 1'b0;
        
  
  always @(posedge clk)
      if (reset) 
        begin
          counter <= #1 7'd0;
          command <= #1 20'd0;
        end
      else if (start) 
        begin
          counter <= #1 7'd1;
          command <= #1 {read,w,addr_data};
        end
      else if (|counter && ~done) 
        begin
          counter <= #1 7'd1+counter;
          if (~counter[0]) command <= {command[22:0],1'b0};
            
        end
        
  wire  done = counter == 8'd49;

  assign sen = (done | counter) == 8'd0;
  assign sclk = ~counter[0];
  assign sdo = command[23];
endmodule

