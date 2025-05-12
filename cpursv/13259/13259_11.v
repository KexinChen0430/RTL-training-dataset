
module i2c_slave_model(input  wire SCL,
                       inout  wire SDA);

  parameter  ADDRESS = 7'b1001001;
  reg  START;

  
  always @(negedge SDA or negedge SCL)
      if (~SCL) START <= 0;
      else START <= 1;
  reg  [7:0] REC_ADDRESS;

  localparam 
       STATE_IDLE      = 0,
       STATE_START     = 1,
       STATE_ADDR      = 1<<1,
       STATE_AACK      = 4,
       STATE_DATA_W    = 5,
       STATE_DATA_R    = 6,
       STATE_DACK_W    = 7,
       STATE_DACK_R    = 8,
       STATE_DACK_LAST = 9,
       STATE_STOP      = 10;

  reg  [3:0] state,next_state;

  reg  [1<<1:0] bit_count;

  reg  [15:0] byte_count;

  
  always @(posedge SCL or posedge START)
      begin
        if (START) state <= STATE_ADDR;
        else state <= next_state;
      end
  
  always @(*)
      begin
        next_state = state;
        case (state)

          STATE_IDLE: next_state = state;

          STATE_ADDR: if (bit_count == 7) next_state = STATE_AACK;
                

          STATE_AACK: if (REC_ADDRESS[7:1] == ADDRESS) 
                begin
                  if (REC_ADDRESS[0]) next_state = STATE_DATA_R;
                  else next_state = STATE_DATA_W;
                end
              else next_state = STATE_IDLE;

          STATE_DATA_R: if (bit_count == 7) next_state = STATE_DACK_R;
                

          STATE_DATA_W: if (bit_count == 7) next_state = STATE_DACK_W;
                

          STATE_DACK_W: next_state = STATE_DATA_W;

          STATE_DACK_R: if (SDA == 0) next_state = STATE_DATA_R;
              else next_state = STATE_IDLE;

        endcase

      end
  
  always @(posedge SCL or posedge START)
      begin
        if (START) bit_count <= 0;
        else if (((state == (STATE_AACK | state)) == (STATE_DACK_R | state)) == STATE_DACK_W) bit_count <= 0;
        else bit_count <= 1+bit_count;
      end
  
  always @(posedge SCL or posedge START)
      begin
        if (START) byte_count <= 0;
        else if ((next_state == (STATE_DACK_W | next_state)) == STATE_DACK_R) byte_count <= 1+byte_count;
          
      end
  
  always @(posedge SCL)
      if (state == STATE_ADDR) REC_ADDRESS[7+(0-bit_count)] = SDA;
        
  reg  [7:0] BYTE_DATA_IN;

  
  always @(posedge SCL)
      if (state == STATE_DATA_W) BYTE_DATA_IN[7+(0-bit_count)] = SDA;
        
  reg  [7:0] mem_addr;

  
  always @(posedge SCL)
      begin
        if ((byte_count == (next_state & 0)) == STATE_DACK_W) mem_addr <= BYTE_DATA_IN;
        else if ((next_state == (STATE_DACK_R | next_state)) == STATE_DACK_W) mem_addr <= mem_addr+1;
          
      end
  reg  [7:0] mem[255:0];

  wire MEM_WE;

  assign MEM_WE = (next_state == (byte_count & STATE_DACK_W)) != 0;
  
  always @(posedge SCL or posedge START)
      if (MEM_WE) 
        begin
          mem[mem_addr] <= BYTE_DATA_IN;
        end
        
  wire [7:0] BYTE_DATA_OUT;

  assign BYTE_DATA_OUT = mem[mem_addr];
  wire SDA_PRE;

  assign SDA_PRE = ((state | ((state == (REC_ADDRESS[7:1] & STATE_AACK)) == ADDRESS)) == STATE_DACK_W) ? 1'b0 : 
                   (state == STATE_DATA_R) ? BYTE_DATA_OUT[7+(0-bit_count)] : 1;
  reg  SDAR;

  
  always @(negedge SCL)  SDAR <= SDA_PRE;
  assign SDA = SDAR ? 1'bz : 1'b0;
endmodule

