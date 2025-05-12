
module ControlUnit(output reg 
      IR_CU     ,
      RFLOAD    ,
      PCLOAD    ,
      SRLOAD    ,
      SRENABLED ,
      ALUSTORE  ,
      MFA       ,
      WORD_BYTE ,
      READ_WRITE,
      IRLOAD    ,
      MBRLOAD   ,
      MBRSTORE  ,
      MARLOAD   ,
                   output reg [4:0] opcode,
                   output reg [3:0] CU,
                   input  MFC,Reset,Clk,
                   input  [31:0] IR,
                   input  [3:0] SR);

  reg  [4:0] State,NextState;

  
  task registerTask;

    input  [17:0] signals;

    
    fork
        #2 
          {CU,IR_CU,RFLOAD,PCLOAD,SRLOAD,opcode,SRENABLED,ALUSTORE,MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE,WORD_BYTE} = {signals[17],1'b0,signals[15],1'b0,signals[13],1'b0,signals[11:9],1'b0,1'b0,1'b0,signals[5:0]};

        #4 
          {CU,IR_CU,RFLOAD,PCLOAD,SRLOAD,opcode,SRENABLED,ALUSTORE,MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE,WORD_BYTE} = signals;

        #6 
          {CU,IR_CU,RFLOAD,PCLOAD,SRLOAD,opcode,SRENABLED,ALUSTORE,MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE,WORD_BYTE} = signals;

    join

  endtask
  
  always @(negedge Clk or posedge Reset)
      if (Reset) 
        begin
          State <= 3'b001;
        end
      else 
        begin
          State <= NextState;
        end
  
  always @(State or MFC)
      case (State)

        3'b000: if (!Reset) NextState = 3'b001;
            else NextState = 3'b000;

        3'b001: NextState = 3'b010;

        3'b010: NextState = 3'b011;

        3'b011: if (MFC) NextState = 3'b100;
            else NextState = 3'b011;

        3'b100: NextState = 3'b101;

        3'b101: begin
              case (IR[31:28])

                4'b0000: begin
                      NextState = 3'b110;
                    end

                4'b0001: begin

                    end

              endcase

            end

        3'b110: begin
              case (IR[24:21])

                4'b0000: begin
                      NextState = 3'b000;
                    end

                4'b0001: begin

                    end

              endcase

            end

        default: NextState = 3'b000;

      endcase

  
  always @(State or MFC)
      case (State)

        3'b000: begin

            end

        3'b001: begin
              IR_CU = 1;
              CU = 4'hf;
              MARLOAD = 1;
              opcode = 16;
            end

        3'b010: begin
              IR_CU = 1;
              CU = 4'hf;
              opcode = 17;
              PCLOAD = 1;
            end

        3'b011: begin
              MFA = 1;
              READ_WRITE = 1;
              WORD_BYTE = 1;
            end

        3'b100: begin
              MBRLOAD = 1;
              IRLOAD = 1;
            end

        3'b101: begin

            end

        3'b110: begin

            end

        default: begin

            end

      endcase

endmodule

