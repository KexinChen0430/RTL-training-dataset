
module INSTRUCTION_DECODER(input  CLK,
                           input  [7:0] RXD,
                           input  RXD_START,
                           input  TXD_DONE,
                           output TXD_ENABLE,
                           output reg MUX_SEL,
                           output reg [9:0] RAM_ADDR,
                           output reg [31:0] TRIG_DATA,
                           output reg TRIG_UPDATE,
                           output reg TRIG_FORCE);

  reg  [2:0]  STATE = 0;
  reg  [1:0] COUNT;
  reg  [23:0] TMP;
  reg  TXD_ENABLE_INT;

  assign TXD_ENABLE = TXD_ENABLE_INT;
  
  always @(posedge CLK)
      case (STATE)

        0: begin
              TXD_ENABLE_INT <= 0;
              TRIG_UPDATE <= 0;
              TRIG_FORCE <= 0;
              COUNT <= 0;
              if (RXD_START && (RXD == 1)) 
                begin
                  STATE <= 1;
                  COUNT <= 0;
                end
                
              if ((RXD == 2) && RXD_START) 
                begin
                  STATE <= 3;
                  TXD_ENABLE_INT <= 1;
                end
                
              if (RXD_START && (RXD == 3)) STATE <= 4;
                
              if ((RXD == 4) && RXD_START) 
                begin
                  STATE <= 5;
                  RAM_ADDR <= 0;
                end
                
            end

        1: begin
              TRIG_UPDATE <= 0;
              if (RXD_START && (COUNT < 3)) 
                begin
                  COUNT <= 1+COUNT;
                  TMP <= {TMP[15:0],RXD};
                end
                
              if (RXD_START && (COUNT == 3)) 
                begin
                  TRIG_DATA <= {TMP[23:0],RXD};
                  STATE <= 2;
                end
                
            end

        2: begin
              TRIG_UPDATE <= 1;
              COUNT <= 0;
              STATE <= 0;
            end

        3: begin
              if (TXD_DONE) 
                begin
                  STATE <= 0;
                  TXD_ENABLE_INT <= 0;
                end
              else MUX_SEL <= 0;
            end

        4: begin
              TRIG_FORCE <= 1;
              STATE <= 0;
            end

        5: begin
              MUX_SEL <= 1;
              TXD_ENABLE_INT <= 1;
              if ((RAM_ADDR == 1023) && TXD_DONE) STATE <= 0;
              else 
                begin
                  if (TXD_DONE) 
                    begin
                      RAM_ADDR <= RAM_ADDR+1;
                    end
                    
                end
            end

      endcase

endmodule

