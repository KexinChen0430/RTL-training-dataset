
module DATA_PHYSICAL(input  wire SD_CLK,
                     input  wire RESET_L,
                     input  wire strobe_IN_DATA_Phy,
                     input  wire ack_IN_DATA_Phy,
                     input  wire [15:0] timeout_Reg_DATA_Phy,
                     input  wire [3:0] blocks_DATA_Phy,
                     input  wire writeRead_DATA_Phy,
                     input  wire multiple_DATA_Phy,
                     input  wire idle_in_DATA_Phy,
                     input  wire transmission_complete_PS_Phy,
                     input  wire reception_complete_SP_Phy,
                     input  wire [31:0] data_read_SP_Phy,
                     input  wire [31:0] dataFromFIFO_FIFO_Phy,
                     output reg serial_Ready_Phy_DATA,
                     output reg complete_Phy_DATA,
                     output reg ack_OUT_Phy_DATA,
                     output reg data_timeout_Phy_DATA,
                     output reg reset_Wrapper_Phy_PS,
                     output reg enable_pts_Wrapper_Phy_PS,
                     output reg enable_stp_Wrapper_Phy_SP,
                     output reg [31:0] dataParallel_Phy_PS,
                     output reg pad_state_Phy_PAD,
                     output reg pad_enable_Phy_PAD,
                     output reg writeFIFO_enable_Phy_FIFO,
                     output reg readFIFO_enable_Phy_FIFO,
                     output reg [31:0] dataReadToFIFO_Phy_FIFO,
                     output reg IO_enable_Phy_SD_CARD);

  parameter  RESET = 11'b00000000001;
  parameter  IDLE = 11'b00000000010;
  parameter  FIFO_READ = 11'b00000000100;
  parameter  LOAD_WRITE = 11'b00000001000;
  parameter  SEND = 11'b00000010000;
  parameter  WAIT_RESPONSE = 11'b00000100000;
  parameter  READ = 11'b00001000000;
  parameter  READ_FIFO_WRITE = 11'b00010000000;
  parameter  READ_WRAPPER_RESET = 11'b00100000000;
  parameter  WAIT_ACK = 11'b01000000000;
  parameter  SEND_ACK = 11'b10000000000;
  reg  [15:0] timeout_input;
  reg  [3:0] blocks;
  reg  [10:0] STATE;
  reg  [10:0] NEXT_STATE;

  
  always @(posedge SD_CLK)
      begin
        if (!RESET_L) 
          begin
            STATE <= RESET;
          end
        else 
          begin
            STATE <= NEXT_STATE;
          end
      end
  
  always @(*)
      begin
        case (STATE)

          RESET: begin

              end

          IDLE: begin

              end

          SEND_ACK: begin

              end

          default: begin
                NEXT_STATE = IDLE;
              end

        endcase

      end
endmodule

