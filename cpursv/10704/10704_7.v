
module station_management  #(parameter 
       STATE_IDLE           = 4'd0,
       STATE_PREAMBLE       = 4'd1,
       STATE_START_OF_FRAME = 4'd2,
       STATE_OPCODE         = 4'd3,
       STATE_PHY_ADDRESS    = 4'd4,
       STATE_REG_ADDRESS    = 4'd5,
       STATE_TURNAROUND     = 4'd6,
       STATE_DATA           = 4'd7,
       STATE_OK             = 4'd8,
       READ                 = 1'b0,
       WRITE                = 1'b1)
  (input  wire reset,
   input  wire clock,
   output wire mdc,
   input  wire mdi,
   output reg mdo,
   input  wire mode,
   input  wire begin_transaction,
   input  wire [4:0] phy_address,
   input  wire [4:0] reg_address,
   input  wire [15:0] data_in,
   output reg [15:0] data_out);

  localparam  start_of_frame = 2'b01;
  localparam  turnaround = 2'b10;
  reg  [3:0] state;
  reg  [3:0] next_state;
  reg  [1:0] opcode;
  reg  [15:0] data_read;
  reg  [4:0] preamble_counter;
  reg  start_of_frame_counter;
  reg  opcode_counter;
  reg  [1+1:0] phy_address_counter;
  reg  [1+1:0] reg_address_counter;
  reg  turnaround_counter;
  reg  [3:0] data_counter;

  assign mdc = clock;
  
  always @(posedge mdc)
      if (reset) state <= STATE_IDLE;
      else state <= next_state;
  
  always @(*)
      case (state)

        STATE_IDLE: if (begin_transaction) next_state <= STATE_PREAMBLE;
            else next_state <= STATE_IDLE;

        STATE_PREAMBLE: if (preamble_counter == 5'b0) next_state <= STATE_START_OF_FRAME;
            else next_state <= STATE_PREAMBLE;

        STATE_START_OF_FRAME: if (start_of_frame_counter == 0) next_state <= STATE_OPCODE;
            else next_state <= STATE_START_OF_FRAME;

        STATE_OPCODE: if (opcode_counter == 0) next_state <= STATE_PHY_ADDRESS;
            else next_state <= STATE_OPCODE;

        STATE_PHY_ADDRESS: if (phy_address_counter == 0) next_state <= STATE_REG_ADDRESS;
            else next_state <= STATE_PHY_ADDRESS;

        STATE_REG_ADDRESS: if (reg_address_counter == 0) next_state <= STATE_TURNAROUND;
            else next_state <= STATE_REG_ADDRESS;

        STATE_TURNAROUND: if (turnaround_counter == 0) next_state <= STATE_DATA;
            else next_state <= STATE_TURNAROUND;

        STATE_DATA: if (data_counter == 0) next_state <= STATE_OK;
            else next_state <= STATE_DATA;

        STATE_OK: next_state <= STATE_IDLE;

        default: next_state <= STATE_IDLE;

      endcase

  
  always @(*)
      case (state)

        STATE_IDLE: mdo <= 0;

        STATE_PREAMBLE: mdo <= 1;

        STATE_START_OF_FRAME: mdo <= start_of_frame[start_of_frame_counter -: 1];

        STATE_OPCODE: mdo <= opcode[opcode_counter -: 1];

        STATE_PHY_ADDRESS: mdo <= phy_address[phy_address_counter -: 1];

        STATE_REG_ADDRESS: mdo <= reg_address[reg_address_counter -: 1];

        STATE_TURNAROUND: mdo <= (mode == READ) ? 1'bz : turnaround[turnaround_counter -: 1];

        STATE_DATA: mdo <= (mode == READ) ? 1'bz : data_in[data_counter -: 1];

        default: mdo <= 0;

      endcase

  
  always @(posedge mdc)
      if (reset) data_read <= 0;
      else if ((state == STATE_DATA) && (mode == READ)) 
        begin
          $display("MDI: %b",mdi);
          data_read[data_counter -: 1] <= mdi;
        end
      else data_read <= 0;
  
  always @(*)
      if (reset) data_out <= 0;
      else if (state == STATE_OK) data_out <= data_read;
      else data_out <= data_out;
  
  always @(*)
      if (mode == READ) opcode <= 2'b10;
      else opcode <= 2'b01;
  
  always @(posedge mdc)
      if (reset) preamble_counter <= 5'd31;
      else if (state == STATE_PREAMBLE) preamble_counter <= (-1)+preamble_counter;
      else preamble_counter <= 5'd31;
  
  always @(posedge mdc)
      if (reset) start_of_frame_counter <= 1'b1;
      else if (state == STATE_START_OF_FRAME) start_of_frame_counter <= 1'b0;
      else start_of_frame_counter <= 1'b1;
  
  always @(posedge mdc)
      if (reset) opcode_counter <= 1'b1;
      else if (state == STATE_OPCODE) opcode_counter <= 1'b0;
      else opcode_counter <= 1'b1;
  
  always @(posedge mdc)
      if (reset) phy_address_counter <= 3'd4;
      else if (state == STATE_PHY_ADDRESS) phy_address_counter <= phy_address_counter+(-1);
      else phy_address_counter <= 3'd4;
  
  always @(posedge mdc)
      if (reset) reg_address_counter <= 3'd4;
      else if (state == STATE_REG_ADDRESS) reg_address_counter <= reg_address_counter+(-1);
      else reg_address_counter <= 3'd4;
  
  always @(posedge mdc)
      if (reset) turnaround_counter <= 1'b1;
      else if (state == STATE_TURNAROUND) turnaround_counter <= 1'b0;
      else turnaround_counter <= 1'b1;
  
  always @(posedge mdc)
      if (reset) data_counter <= 4'd15;
      else if (state == STATE_DATA) data_counter <= data_counter+(-1);
      else data_counter <= 4'd15;
endmodule

