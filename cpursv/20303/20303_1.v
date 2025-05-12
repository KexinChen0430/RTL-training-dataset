
module controlTransmitter(Complete,NullString,NullDataChar,Generated,LoadString,
                          CompareString,LoadNextChar,GenerateData,SendData,Reset,clk);

  input  
      Complete    ,
      NullString  ,
      NullDataChar,
      clk         ,
      Reset       ,
      Generated   ;
  output reg 
      LoadString   ,
      CompareString,
      LoadNextChar ,
      GenerateData ,
      SendData     ;
  reg  [2:0] current_state;
  reg  [2:0] next_state;
  parameter 
       Standby         = 3'b000,
       LoadingString   = 3'b001,
       ComparingString = 3'b010,
       LoadingChar     = 3'b011;
  parameter  GeneratingData = 3'b100, SendingData = 3'b101;

  
  always @(Complete or NullString or NullDataChar or current_state or Reset or Generated)
      begin
        if (Reset) 
          begin
            next_state <= Standby;
            LoadString <= 0;
            CompareString <= 0;
            LoadNextChar <= 0;
            GenerateData <= 0;
            SendData <= 0;
          end
        else 
          begin
            case (current_state)

              Standby: begin

                  end

              LoadingString: begin

                  end

              ComparingString: begin

                  end

              LoadingChar: begin

                  end

              GeneratingData: begin

                  end

              SendingData: begin

                  end

              default: begin

                  end

            endcase

          end
      end
  
  always @(negedge clk)
      begin
        current_state <= next_state;
      end
endmodule

