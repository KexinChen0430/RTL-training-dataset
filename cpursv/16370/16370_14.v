
module spi_wrapper(input  clk,
                   input  reset,
                   input  mosi,
                   input  ss,
                   input  sck,
                   output miso,
                   input  [31:0] data_in,
                   output data_in_rdy,
                   output data_in_ack,
                   input  data_in_rq,
                   output reg [31:0] data_out,
                   output reg data_out_rdy,
                   input  data_out_ack,
                   output reg spi_led);

  reg  [2:0] SCKr;

  
  always @(posedge clk)  SCKr <= {SCKr[1:0],sck};
  wire  SCK_risingedge = SCKr[2:1] == 3'b01;

  wire  SCK_fallingedge = SCKr[2:1] == 2'b10;

  reg  [2:0] SSELr;

  
  always @(posedge clk)  SSELr <= {SSELr[1:0],ss};
  wire  SSEL_active = ~SSELr[1];

  wire  SSEL_startmessage = SSELr[2:1] == 2'b10;

  wire  SSEL_endmessage = SSELr[2:1] == 2'b01;

  reg  [1:0] MOSIr;

  
  always @(posedge clk)  MOSIr <= {MOSIr[0],mosi};
  wire  MOSI_data = MOSIr[1];

  reg  [4:0] bitcnt;

  reg  [3:0] bitcnt_b;

  reg  [31:0] word_data_received;

  reg  [2:0] bytecnt;

  reg  [4:0] started;

  reg  [31:0] echo;

  
  always @(posedge clk)
      if (!reset) 
        begin
          started <= 0;
          echo <= 0;
          data_out <= 0;
          data_out_rdy <= 0;
          bitcnt <= 0;
          bytecnt <= 0;
          bitcnt_b <= 0;
        end
      else 
        begin
          if (data_out_ack) data_out_rdy <= 0;
            
          if (~SSEL_active) 
            begin
              spi_led <= 1;
              bitcnt_b <= 0;
              started <= 5'b10101;
              if (started != 5'b10101) 
                begin
                  bitcnt <= 0;
                  word_data_sent <= data_in;
                end
              else if (bitcnt == 5'b11111) word_data_sent <= data_in;
                
            end
          else if (SCK_risingedge) 
            begin
              word_data_received <= {word_data_received[30:0],MOSI_data};
              if (bitcnt == 5'b11111) 
                begin
                  data_out <= {word_data_received[30:0],MOSI_data};
                  data_out_rdy <= 1;
                end
                
            end
          else if (SCK_fallingedge) 
            begin
              if (bitcnt == 5'b11111) 
                begin
                  word_data_sent <= data_in;
                end
              else 
                begin
                  spi_led <= ~spi_led;
                  word_data_sent <= {word_data_sent[30:0],1'b0};
                end
              bitcnt <= 1+bitcnt;
              bitcnt_b <= 1+bitcnt_b;
            end
            
        end
  
  always @(posedge clk)
      if (SCK_fallingedge && (bitcnt == 0) && SSEL_active) bytecnt <= 0;
      else if ((bitcnt_b == 3'b111) && 
               (SSEL_active && SCK_fallingedge)) bytecnt <= 1+bytecnt;
        
  reg  [31:0] cnt;

  
  always @(posedge clk)
      if (SSEL_startmessage) cnt <= cnt+1;
        
  reg  [31:0] word_data_sent;

  assign data_in_rdy = bitcnt == 5'b00000;
  assign data_in_ack = bitcnt == 5'b11111;
  assign miso = word_data_sent[31];
endmodule

