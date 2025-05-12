module uart_v3 #(
  parameter DEFAULT_BAUDRATE  = 115200, 
  parameter STOP_BITS         = 1       
)(
  input               clk,               
  input               rst,               
  output  reg         tx,                
  input               transmit,          
  input       [7:0]   tx_byte,           
  output              is_transmitting,   
  input               rx,                
  output  reg         rx_error,          
  output  reg [7:0]   rx_byte,           
  output  reg         received,          
  output              is_receiving,      
  output      [31:0]  prescaler,         
  input               set_clock_div,     
  input       [31:0]  user_clock_div,    
  output      [31:0]  default_clock_div  
);
localparam  RX_IDLE           = 0; 
localparam  RX_CHECK_START    = 1; 
localparam  RX_READING        = 2; 
localparam  RX_CHECK_STOP     = 3; 
localparam  RX_DELAY_RESTART  = 4; 
localparam  RX_ERROR          = 5; 
localparam  RX_RECEIVED       = 6; 
localparam  TX_IDLE           = 0; 
localparam  TX_SENDING        = 1; 
localparam  TX_FINISHED       = 2; 
reg         [2:0]             rx_state;            
reg         [3:0]             rx_bit_count;        
reg         [7:0]             rx_data;             
reg         [31:0]            rx_clock_div;        
reg         [31:0]            rx_clock_div_count;  
reg         [31:0]            rx_prescaler_count;  
reg         [2:0]             tx_state;            
reg         [3:0]             tx_bit_count;        
reg         [7:0]             tx_data;             
reg         [31:0]            tx_clock_div;        
reg         [31:0]            tx_prescaler_count;  
reg         [31:0]            tx_clock_div_count;  
assign      prescaler         = `CLOCK_RATE / (`PRESCALER_COUNT); 
assign      default_clock_div = `CLOCK_RATE / (`PRESCALER_COUNT * DEFAULT_BAUDRATE); 
assign      is_receiving      = (rx_state != RX_IDLE); 
assign      is_transmitting   = (tx_state != TX_IDLE); 
always @ (posedge clk) begin
  if (rst || set_clock_div) begin
    rx_state                  <=  RX_IDLE;
    rx_bit_count              <=  0;
    rx_clock_div_count        <=  0;
    rx_clock_div              <=  `FULL_PERIOD; 
    rx_data                   <=  0;
    rx_byte                   <=  0;
    rx_error                  <=  0;
    if (set_clock_div) begin
      rx_clock_div            <=  user_clock_div;
    end
    else begin
      rx_clock_div            <=  default_clock_div;
    end
  end
  else begin
    received                  <=  0;
    rx_error                  <=  0;
    rx_clock_div_count        <=  rx_clock_div_count + 1;
    if (rx_clock_div_count >= rx_clock_div) begin
      rx_prescaler_count     <=  rx_prescaler_count + 1;
      rx_clock_div_count      <=  0;
    end
  end
end
always @ (posedge clk) begin
  if (rst || set_clock_div) begin
    tx                        <=  1; 
    tx_state                  <=  TX_IDLE;
    tx_data                   <=  0;
    tx_bit_count              <=  0;
    tx_clock_div_count        <=  0;
    tx_prescaler_count        <=  0;
    if (set_clock_div) begin
      tx_clock_div            <=  user_clock_div;
    end
    else begin
      tx_clock_div            <=  default_clock_div;
    end
  end
  else begin
    tx_clock_div_count        <=  tx_clock_div_count + 1;
    if (tx_clock_div_count >= tx_clock_div) begin
      tx_prescaler_count      <=  tx_prescaler_count + 1;
      tx_clock_div_count      <=  0;
    end
  end
end
endmodule