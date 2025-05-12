module uart_transmitter(
  input wire       clk,                
  input wire       rst_n,              
  input wire [7:0] tx_byte,            
  input wire       tx_byte_valid,      
  output wire      tx_byte_done_out,   
  output wire      tx_out              
);
  parameter ClocksPerBaud = `DEFAULT_CLOCKS_PER_BAUD;
  localparam CountdownBits = $clog2(ClocksPerBaud);
  localparam CountdownStart = ClocksPerBaud-1;
  localparam
      StateIdle  = 'd0,  
      StateStart = 'd1,  
      StateFrame = 'd2,  
      StateStop  = 'd3;  
  localparam StateBits = 2;
  reg                     tx = 1;                  
  reg                     tx_byte_done = 1;        
  reg [StateBits-1:0]     tx_state = StateIdle;    
  reg [CountdownBits-1:0] tx_countdown = 0;        
  reg [2:0]               tx_bitno = 0;            
  reg                     tx_next;                 
  reg                     tx_byte_done_next;       
  reg [StateBits-1:0]     tx_state_next;           
  reg [CountdownBits-1:0] tx_countdown_next;       
  reg [2:0]               tx_bitno_next;           
  assign tx_out           = tx;
  assign tx_byte_done_out = tx_byte_done;
  always @(*) begin
    tx_state_next = tx_state;  
    case (tx_state)
      StateIdle: begin  
        if (tx_byte_valid || !tx_byte_done) begin
          tx_state_next = StateStart;  
        end
      end
      StateStart: begin  
        if (tx_countdown == 0) begin
          tx_state_next = StateFrame;  
        end
      end
      StateFrame: begin  
        if (tx_countdown == 0 && tx_bitno == 7) begin
          tx_state_next = StateStop;  
        end
      end
      StateStop: begin  
        if (tx_countdown == 0) begin
          tx_state_next = tx_byte_done ? StateIdle : StateStart;
        end
      end
      default: begin  
        tx_state_next     = 1'bX;  
      end
    endcase
  end
  always @(*) begin
    tx_next           = tx;
    tx_byte_done_next = tx_byte_done;
    tx_bitno_next     = tx_bitno;
    tx_countdown_next = tx_countdown;
    case (tx_state)
      StateIdle: begin  
        tx_next           = 1;  
        tx_bitno_next     = 0;  
        tx_countdown_next = CountdownStart;  
        tx_byte_done_next = !tx_byte_valid;  
      end
      StateStart: begin  
        tx_next           = 0;  
        tx_byte_done_next = 0;  
        tx_bitno_next     = 0;  
        tx_countdown_next = tx_countdown == 0 ? CountdownStart : tx_countdown - 1;
      end
      StateFrame: begin  
        tx_next           = tx_byte[tx_bitno];  
        tx_byte_done_next = tx_countdown == 0 && tx_bitno == 7;
        tx_bitno_next     = tx_countdown == 0 ? tx_bitno + 1 : tx_bitno;
        tx_countdown_next = tx_countdown == 0 ? CountdownStart : tx_countdown - 1;
      end
      StateStop: begin  
        tx_next           = 1;  
        tx_byte_done_next = (tx_byte_done == 0 || tx_byte_valid == 1) ? 0 : 1;
        tx_countdown_next = tx_countdown == 0 ? CountdownStart : tx_countdown - 1;
      end
      default: begin  
        tx_next           = 1'bX;
        tx_byte_done_next = 1'bX;
        tx_bitno_next     = 1'bX;
        tx_countdown_next = 1'bX;
      end
    endcase
  end
  always @ (posedge clk) begin
    if (rst_n == 0) begin  
      tx           <= 1;
      tx_byte_done <= 1;
      tx_state     <= StateIdle;
      tx_countdown <= 0;
      tx_bitno     <= 0;
    end else begin  
      tx           <= tx_next;
      tx_byte_done <= tx_byte_done_next;
      tx_state     <= tx_state_next;
      tx_countdown <= tx_countdown_next;
      tx_bitno     <= tx_bitno_next;
    end
  end
endmodule