
module task_uart(tx,rx);

  output tx;
  input  rx;
  reg  tx;
  reg  clk,clk2;
  reg  [7:0] rdata;
  reg  rx_valid;
  wire [7:0] rx_char;

  
  initial  
  begin
    clk <= 1'b0;
    clk2 <= 1'b0;
    tx <= 1'b1;
  end
  
  always 
      begin
        #((1000000000/2)*(1/115200)) clk <= ~clk;
      end
  
  always 
      begin
        #((1/2)*((1000000000/2)*(1/115200))) clk2 <= ~clk2;
      end
  
  task write;

    input  [7:0] data;

    begin
      @(posedge clk)  ;
      tx <= 1'b1;
      @(posedge clk)  ;
      tx <= 1'b0;
      @(posedge clk)  ;
      tx <= data[0];
      @(posedge clk)  ;
      tx <= data[1];
      @(posedge clk)  ;
      tx <= data[2];
      @(posedge clk)  ;
      tx <= data[3];
      @(posedge clk)  ;
      tx <= data[4];
      @(posedge clk)  ;
      tx <= data[5];
      @(posedge clk)  ;
      tx <= data[6];
      @(posedge clk)  ;
      tx <= data[7];
      @(posedge clk)  ;
      tx <= 1'b1;
      @(posedge clk)  ;
      tx <= 1'b1;
      @(posedge clk)  ;
    end
  endtask
  
  always 
      begin
        rx_valid <= 0;
        @(posedge clk2)  ;
        if (rx == 1'b0) 
          begin
            repeat (2)
              @(posedge clk2)  ;
            rdata[0] <= rx;
            repeat (2)
              @(posedge clk2)  ;
            rdata[1] <= rx;
            repeat (2)
              @(posedge clk2)  ;
            rdata[2] <= rx;
            repeat (2)
              @(posedge clk2)  ;
            rdata[3] <= rx;
            repeat (2)
              @(posedge clk2)  ;
            rdata[4] <= rx;
            repeat (2)
              @(posedge clk2)  ;
            rdata[5] <= rx;
            repeat (2)
              @(posedge clk2)  ;
            rdata[6] <= rx;
            repeat (2)
              @(posedge clk2)  ;
            rdata[7] <= rx;
            repeat (2)
              @(posedge clk2)  ;
            if (rx == 1'b1) 
              begin
                rx_valid <= 1;
                $write("%s",rdata[7:0]);
              end
              
            repeat (2)
              @(posedge clk2)  ;
          end
          
      end
  assign rx_char = rx_valid ? rdata : 8'd0;
endmodule

