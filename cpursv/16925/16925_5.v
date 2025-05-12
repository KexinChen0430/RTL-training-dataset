
module fb2ahb_asynbrig_if(A2F_HRDATAS,AHB_ASYNC_READ_EN_I,AHB_ASYNC_WRITE_EN_I,
                          AHB_ASYNC_BYTE_STROBE_I,AHB_ASYNC_STB_TOGGLE_I,WB_CLK_I,
                          WB_RST_I,WB_ACK_I,WB_DAT_I,WB_CYC_O,WB_BYTE_STB_O,WB_WE_O,
                          WB_RD_O,WB_STB_O,FABRIC_ASYNC_ACK_TOGGLE_O);

  parameter  DATAWIDTH = 32;
  parameter  STATE_WIDTH = 1;
  parameter  FAB_ASYNC_IDLE = 0;
  parameter  FAB_ASYNC_WAIT = 1;
  output [DATAWIDTH-1:0] A2F_HRDATAS;
  input  AHB_ASYNC_READ_EN_I;
  input  AHB_ASYNC_WRITE_EN_I;
  input  [3:0] AHB_ASYNC_BYTE_STROBE_I;
  input  AHB_ASYNC_STB_TOGGLE_I;
  input  WB_CLK_I;
  input  WB_RST_I;
  input  WB_ACK_I;
  input  [DATAWIDTH-1:0] WB_DAT_I;
  output WB_CYC_O;
  output [3:0] WB_BYTE_STB_O;
  output WB_WE_O;
  output WB_RD_O;
  output WB_STB_O;
  output FABRIC_ASYNC_ACK_TOGGLE_O;
  reg  [DATAWIDTH-1:0] A2F_HRDATAS;
  reg  [DATAWIDTH-1:0] A2F_HRDATAS_nxt;
  wire AHB_ASYNC_READ_EN_I;
  wire AHB_ASYNC_WRITE_EN_I;
  wire [3:0] AHB_ASYNC_BYTE_STROBE_I;
  wire AHB_ASYNC_STB_TOGGLE_I;
  wire WB_CLK_I;
  wire WB_RST_I;
  wire WB_ACK_I;
  reg  WB_CYC_O;
  reg  WB_CYC_O_nxt;
  reg  [3:0] WB_BYTE_STB_O;
  reg  [3:0] WB_BYTE_STB_O_nxt;
  reg  WB_WE_O;
  reg  WB_WE_O_nxt;
  reg  WB_RD_O;
  reg  WB_RD_O_nxt;
  reg  WB_STB_O;
  reg  WB_STB_O_nxt;
  reg  FABRIC_ASYNC_ACK_TOGGLE_O;
  reg  FABRIC_ASYNC_ACK_TOGGLE_O_nxt;
  reg  [STATE_WIDTH-1:0] fabric_to_ahb_state;
  reg  [STATE_WIDTH-1:0] fabric_to_ahb_state_nxt;
  reg  ahb_async_stb_toggle_i_1ff;
  reg  ahb_async_stb_toggle_i_2ff;
  reg  ahb_async_stb_toggle_i_3ff;
  wire ahb_async_stb;

  assign ahb_async_stb = (~ahb_async_stb_toggle_i_2ff & ahb_async_stb_toggle_i_3ff) | ((~ahb_async_stb_toggle_i_3ff | ~ahb_async_stb_toggle_i_2ff) & ((~ahb_async_stb_toggle_i_3ff | ahb_async_stb_toggle_i_3ff) & ahb_async_stb_toggle_i_2ff));
  
  always @(posedge WB_CLK_I or posedge WB_RST_I)
      begin
        if (WB_RST_I) 
          begin
            fabric_to_ahb_state <= FAB_ASYNC_IDLE;
            A2F_HRDATAS <= {DATAWIDTH{1'b0}};
            WB_CYC_O <= 1'b0;
            WB_BYTE_STB_O <= 4'b0;
            WB_WE_O <= 1'b0;
            WB_RD_O <= 1'b0;
            WB_STB_O <= 1'b0;
            FABRIC_ASYNC_ACK_TOGGLE_O <= 1'b0;
            ahb_async_stb_toggle_i_1ff <= 1'b0;
            ahb_async_stb_toggle_i_2ff <= 1'b0;
            ahb_async_stb_toggle_i_3ff <= 1'b0;
          end
        else 
          begin
            fabric_to_ahb_state <= fabric_to_ahb_state_nxt;
            A2F_HRDATAS <= A2F_HRDATAS_nxt;
            WB_CYC_O <= WB_CYC_O_nxt;
            WB_BYTE_STB_O <= WB_BYTE_STB_O_nxt;
            WB_WE_O <= WB_WE_O_nxt;
            WB_RD_O <= WB_RD_O_nxt;
            WB_STB_O <= WB_STB_O_nxt;
            FABRIC_ASYNC_ACK_TOGGLE_O <= FABRIC_ASYNC_ACK_TOGGLE_O_nxt;
            ahb_async_stb_toggle_i_1ff <= AHB_ASYNC_STB_TOGGLE_I;
            ahb_async_stb_toggle_i_2ff <= ahb_async_stb_toggle_i_1ff;
            ahb_async_stb_toggle_i_3ff <= ahb_async_stb_toggle_i_2ff;
          end
      end
  
  always @(ahb_async_stb or AHB_ASYNC_READ_EN_I or AHB_ASYNC_WRITE_EN_I or AHB_ASYNC_BYTE_STROBE_I or A2F_HRDATAS or WB_ACK_I or WB_DAT_I or WB_CYC_O or WB_BYTE_STB_O or WB_WE_O or WB_RD_O or WB_STB_O or FABRIC_ASYNC_ACK_TOGGLE_O or fabric_to_ahb_state)
      begin
        case (fabric_to_ahb_state)

          FAB_ASYNC_IDLE: begin
                FABRIC_ASYNC_ACK_TOGGLE_O_nxt <= FABRIC_ASYNC_ACK_TOGGLE_O;
                A2F_HRDATAS_nxt <= A2F_HRDATAS;
                case (ahb_async_stb)

                  1'b0: begin
                        fabric_to_ahb_state_nxt <= FAB_ASYNC_IDLE;
                        WB_CYC_O_nxt <= 1'b0;
                        WB_BYTE_STB_O_nxt <= 4'b0;
                        WB_WE_O_nxt <= 1'b0;
                        WB_RD_O_nxt <= 1'b0;
                        WB_STB_O_nxt <= 1'b0;
                      end

                  1'b1: begin
                        fabric_to_ahb_state_nxt <= FAB_ASYNC_WAIT;
                        WB_CYC_O_nxt <= 1'b1;
                        WB_BYTE_STB_O_nxt <= AHB_ASYNC_BYTE_STROBE_I;
                        WB_WE_O_nxt <= AHB_ASYNC_WRITE_EN_I;
                        WB_RD_O_nxt <= AHB_ASYNC_READ_EN_I;
                        WB_STB_O_nxt <= 1'b1;
                      end

                endcase

              end

          FAB_ASYNC_WAIT: begin
                case (WB_ACK_I)

                  1'b0: begin
                        fabric_to_ahb_state_nxt <= FAB_ASYNC_WAIT;
                        A2F_HRDATAS_nxt <= A2F_HRDATAS;
                        WB_CYC_O_nxt <= WB_CYC_O;
                        WB_BYTE_STB_O_nxt <= WB_BYTE_STB_O;
                        WB_WE_O_nxt <= WB_WE_O;
                        WB_RD_O_nxt <= WB_RD_O;
                        WB_STB_O_nxt <= WB_STB_O;
                        FABRIC_ASYNC_ACK_TOGGLE_O_nxt <= FABRIC_ASYNC_ACK_TOGGLE_O;
                      end

                  1'b1: begin
                        fabric_to_ahb_state_nxt <= FAB_ASYNC_IDLE;
                        A2F_HRDATAS_nxt <= WB_DAT_I;
                        WB_CYC_O_nxt <= 1'b0;
                        WB_BYTE_STB_O_nxt <= 4'b0;
                        WB_WE_O_nxt <= 1'b0;
                        WB_RD_O_nxt <= 1'b0;
                        WB_STB_O_nxt <= 1'b0;
                        FABRIC_ASYNC_ACK_TOGGLE_O_nxt <= ~FABRIC_ASYNC_ACK_TOGGLE_O;
                      end

                endcase

              end

          default: begin
                fabric_to_ahb_state_nxt <= FAB_ASYNC_IDLE;
                A2F_HRDATAS_nxt <= A2F_HRDATAS;
                WB_CYC_O_nxt <= 1'b0;
                WB_BYTE_STB_O_nxt <= 4'b0;
                WB_WE_O_nxt <= 1'b0;
                WB_RD_O_nxt <= 1'b0;
                WB_STB_O_nxt <= 1'b0;
                FABRIC_ASYNC_ACK_TOGGLE_O_nxt <= FABRIC_ASYNC_ACK_TOGGLE_O;
              end

        endcase

      end
endmodule

