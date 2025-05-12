module station_management
#(
    parameter STATE_IDLE            = 4'd0,
    parameter STATE_PREAMBLE        = 4'd1,
    parameter STATE_START_OF_FRAME  = 4'd2,
    parameter STATE_OPCODE          = 4'd3,
    parameter STATE_PHY_ADDRESS     = 4'd4,
    parameter STATE_REG_ADDRESS     = 4'd5,
    parameter STATE_TURNAROUND      = 4'd6,
    parameter STATE_DATA            = 4'd7,
    parameter STATE_OK              = 4'd8,
    parameter READ                  = 1'b0,
    parameter WRITE                 = 1'b1
)(
    input   wire reset,             
    input   wire clock,             
    output  wire mdc,               
    inout   wire mdio,              
    input   wire mode,              
    input   wire begin_transaction, 
    input   wire [4:0] phy_address, 
    input   wire [4:0] reg_address, 
    input   wire [15:0] data_in,    
    output  reg  [15:0] data_out    
);
localparam start_of_frame   = 2'b01;
localparam turnaround       = 2'b10;
reg [3:0] state;                  
reg [3:0] next_state;             
reg mdio_data;                    
reg writing;                      
reg [1:0] opcode;                 
reg [15:0] data_read;             
reg [4:0] preamble_counter;       
reg       start_of_frame_counter; 
reg       opcode_counter;         
reg [2:0] phy_address_counter;    
reg [2:0] reg_address_counter;    
reg       turnaround_counter;     
reg [3:0] data_counter;           
assign mdc = clock;
assign mdio = (writing) ? mdio_data : 1'bz;
always @(posedge mdc)
    if (reset)
        state <= STATE_IDLE;       
    else
        state <= next_state;       
always @(*)
    case(state)
        STATE_IDLE:
            if (begin_transaction)
                next_state <= STATE_PREAMBLE;
            else
                next_state <= STATE_IDLE;
        STATE_OK:
            next_state <= STATE_IDLE;
        default:
            next_state <= STATE_IDLE;
    endcase
always @(*)
    case(state)
        STATE_IDLE:
            mdio_data <= 0; 
        default:
            mdio_data <= 0; 
    endcase
always @(posedge mdc)
    if (state == STATE_DATA && mode == READ)
        data_read[data_counter-:1] <= mdio;
always @(*)
    if (state == STATE_OK)
    begin
        data_out <= data_read;
    end
always @(*)
    if ((state == STATE_TURNAROUND && mode == READ) ||
        (state == STATE_DATA       && mode == READ))
        writing <= 0; 
    else
        writing <= 1; 
always @(*)
    if (mode == READ)
        opcode <= 2'b10; 
    else
        opcode <= 2'b01; 
endmodule