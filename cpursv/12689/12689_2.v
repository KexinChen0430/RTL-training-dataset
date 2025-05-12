
module sd_ctrl(reset,clock,sd_in,sd_out,emmit_command,command_timeout,
               response_ready,serialize_complete,deserialize_complete,
               enable_serializer,enable_deserializer,reset_serializer,
               big_response,frame_deserializer);

  input  
      reset               ,
      clock               ,
      deserialize_complete,
      serialize_complete  ,
      emmit_command       ,
      big_response        ;
  output reg 
      enable_serializer  ,
      enable_deserializer,
      reset_serializer   ,
      response_ready     ,
      command_timeout    ,
      frame_deserializer ;
  input  [135:0] sd_in;
  output [47:0] sd_out;
  parameter 
       RESET             = 0,
       IDLE              = 1,
       HOST_TO_SD_TRANSF = 2,
       WAIT_RESPONSE     = 3,
       SD_TO_HOST_TRANSF = 4;
  reg  [2:0] state;
  reg  [5:0] timeout_counter;

  
  always @(posedge reset)
      begin
        state <= RESET;
      end
  
  always @(posedge clock)
      case (state)

        RESET: begin
              reset_serializer <= 1;
              reset_deserializer <= 1;
              state <= IDLE;
              timeout_counter <= 0;
            end

        IDLE: begin
              response_ready <= 0;
              reset_serializer <= 0;
              if (emmit_command) 
                begin
                  state <= HOST_TO_SD_TRANSF;
                end
                
            end

        HOST_TO_SD_TRANSF: begin
              frame_deserializer <= big_response ? 135 : 47;
              enable_serializer <= 1;
              if (serialize_complete) 
                begin
                  state <= WAIT_RESPONSE;
                end
                
            end

        WAIT_RESPONSE: begin
              enable_serializer <= 0;
              reset_serializer <= 1;
              timeout_counter <= 1+timeout_counter;
              if (timeout_counter == 63) 
                begin
                  command_timeout <= 1;
                  state <= IDLE;
                end
              else if (deserialize_complete) 
                begin
                  enable_deserializer <= 1;
                  state <= SD_TO_HOST_TRANSF;
                end
                
            end

        SD_TO_HOST_TRANSF: begin
              timeout_counter <= 0;
              if (deserialize_complete) 
                begin
                  response_ready <= 1;
                  state <= IDLE;
                end
                
            end

        default: begin

            end

      endcase

endmodule

