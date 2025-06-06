
module I2C_Controller(CLOCK,I2C_SCLK,I2C_SDAT,I2C_DATA,GO,END,ACK,RESET);

  input  CLOCK;
  input  [31:0] I2C_DATA;
  input  GO;
  input  RESET;
  inout  I2C_SDAT;
  output I2C_SCLK;
  output END;
  output ACK;
  reg  SDO;
  reg  SCLK;
  reg  END;
  reg  [31:0] SD;
  reg  [6:0] SD_COUNTER;
  wire 
       I2C_SCLK = SCLK | (((SD_COUNTER <= 39) & (SD_COUNTER >= 4)) ? ~CLOCK : 0);
  wire  I2C_SDAT = SDO ? 1'bz : 0;
  reg  ACK1,ACK2,ACK3,ACK4;
  wire  ACK = (ACK2 | ACK3) | (ACK4 | ACK1);

  
  always @(negedge RESET or posedge CLOCK)
      begin
        if (!RESET) SD_COUNTER = 6'b111111;
        else 
          begin
            if (GO == 0) SD_COUNTER = 0;
            else if (SD_COUNTER < 41) SD_COUNTER = SD_COUNTER+1;
              
          end
      end
  
  always @(negedge RESET or posedge CLOCK)
      begin
        if (!RESET) 
          begin
            SCLK = 1;
            SDO = 1;
            ACK1 = 0;
            ACK2 = 0;
            ACK3 = 0;
            ACK4 = 0;
            END = 1;
          end
        else 
          begin
            case (SD_COUNTER)

              6'd0: begin
                    ACK1 = 0;
                    ACK2 = 0;
                    ACK3 = 0;
                    ACK4 = 0;
                    END = 0;
                    SDO = 1;
                    SCLK = 1;
                  end

              6'd1: begin
                    SD = I2C_DATA;
                    SDO = 0;
                  end

              6'd2: SCLK = 0;

              6'd3: SDO = SD[31];

              6'd4: SDO = SD[30];

              6'd5: SDO = SD[29];

              6'd6: SDO = SD[28];

              6'd7: SDO = SD[27];

              6'd8: SDO = SD[26];

              6'd9: SDO = SD[25];

              6'd10: SDO = SD[24];

              6'd11: SDO = 1'b1;

              6'd12: begin
                    SDO = SD[23];
                    ACK1 = I2C_SDAT;
                  end

              6'd13: SDO = SD[22];

              6'd14: SDO = SD[21];

              6'd15: SDO = SD[20];

              6'd16: SDO = SD[19];

              6'd17: SDO = SD[18];

              6'd18: SDO = SD[17];

              6'd19: SDO = SD[16];

              6'd20: SDO = 1'b1;

              6'd21: begin
                    SDO = SD[15];
                    ACK2 = I2C_SDAT;
                  end

              6'd22: SDO = SD[14];

              6'd23: SDO = SD[13];

              6'd24: SDO = SD[12];

              6'd25: SDO = SD[11];

              6'd26: SDO = SD[10];

              6'd27: SDO = SD[9];

              6'd28: SDO = SD[8];

              6'd29: SDO = 1'b1;

              6'd30: begin
                    SDO = SD[7];
                    ACK3 = I2C_SDAT;
                  end

              6'd31: SDO = SD[6];

              6'd32: SDO = SD[5];

              6'd33: SDO = SD[4];

              6'd34: SDO = SD[3];

              6'd35: SDO = SD[2];

              6'd36: SDO = SD[1];

              6'd37: SDO = SD[0];

              6'd38: SDO = 1'b1;

              6'd39: begin
                    SDO = 1'b0;
                    SCLK = 1'b0;
                    ACK4 = I2C_SDAT;
                  end

              6'd40: SCLK = 1'b1;

              6'd41: begin
                    SDO = 1'b1;
                    END = 1;
                  end

            endcase

          end
      end
endmodule

