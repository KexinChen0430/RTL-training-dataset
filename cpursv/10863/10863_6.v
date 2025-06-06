
module spi_slave  #(parameter  msg_len = 8)
  (CLK,SCK,MOSI,MISO,SSEL,MSG);

  input  wire CLK;
  input  wire SCK,SSEL,MOSI;
  output wire MISO;
  output wire [msg_len-1:0] MSG;

  assign MISO = 0;
  reg  [1+1:0] SCKr;

  
  initial    SCKr <= 3'd0;
  
  always @(posedge CLK)  SCKr <= {SCKr[1:0],SCK};
  wire  SCK_risingedge = SCKr[1+1:1] == 2'b01;

  reg  [1+1:0] SSELr;

  
  initial    SSELr <= 3'd0;
  
  always @(posedge CLK)  SSELr <= {SSELr[1:0],SSEL};
  wire  SSEL_active = ~SSELr[1];

  reg  [1:0] MOSIr;

  
  initial    MOSIr <= 2'd0;
  
  always @(posedge CLK)  MOSIr <= {MOSIr[0],MOSI};
  wire  MOSI_data = MOSIr[1];

  reg  [$clog2(1+msg_len)+(0-1):0] bitcnt;

  
  initial    bitcnt <= {$clog2(1+msg_len)+(0-1){1'b0}};
  reg  is_msg_received;

  
  initial    is_msg_received <= 0;
  reg  [msg_len-1:0] msg_data_received;

  
  initial    msg_data_received <= {msg_len{1'b0}};
  
  always @(posedge CLK)
      begin
        if (~SSEL_active) bitcnt <= 3'b000;
        else if (SCK_risingedge) 
          begin
            bitcnt <= 3'b001+bitcnt;
            if (bitcnt < msg_len) msg_data_received <= {msg_data_received[6:0],MOSI_data};
              
          end
          
      end
  
  always @(posedge CLK)
      is_msg_received <= (bitcnt == 3'b111) && (SSEL_active && SCK_risingedge);
  assign MSG = msg_data_received;
endmodule

