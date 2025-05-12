
module sonic_sensor(input  clk,
                    input  rst,
                    input  req,
                    output busy,
                    inout  sig,
                    output [31:0] out_data,
                    output [3:0] led);

  parameter 
       STATE_INIT        = 0,
       STATE_IDLE        = 1,
       STATE_OUT_SIG     = 2,
       STATE_OUT_END     = 3,
       STATE_WAIT750     = 4,
       STATE_IN_SIG_WAIT = 5,
       STATE_IN_SIG      = 6,
       STATE_IN_SIG_END  = 7,
       STATE_WAIT200     = 8;
  reg  [3:0] state;
  reg  [31:0] echo;
  reg  [32:0] counter;
  reg  [31:0] result;
  wire count_5u;
  wire count_750u;
  wire count_200u;
  wire time_out;
  wire echo_fl;

  assign count_5u = counter == 499;
  assign count_750u = counter == 74998;
  assign count_200u = counter == 19999;
  assign time_out = counter == 2000;
  assign echo_fl = (echo > 1850000) ? 1 : 0;
  assign sig = (state == STATE_OUT_SIG) ? 1 : 1'bZ;
  assign busy = (state > STATE_IDLE) ? 1 : 0;
  
  always @(posedge clk)
      begin
        if (rst) state <= STATE_INIT;
        else 
          case (state)

            STATE_INIT: state <= STATE_IDLE;

            STATE_IDLE: if (req) state <= STATE_OUT_SIG;
                  

            STATE_OUT_SIG: if (count_5u) state <= STATE_OUT_END;
                  

            STATE_OUT_END: state <= STATE_WAIT750;

            STATE_WAIT750: if (count_750u) state <= STATE_IN_SIG_WAIT;
                  

            STATE_IN_SIG_WAIT: state <= STATE_IN_SIG;

            STATE_IN_SIG: begin
                  if ((sig == 0) || echo_fl) state <= STATE_IN_SIG_END;
                  else if ((echo == 0) && time_out) state <= STATE_INIT;
                    
                end

            STATE_IN_SIG_END: state <= STATE_WAIT200;

            STATE_WAIT200: if (count_200u) state <= STATE_IDLE;
                  

          endcase

      end
  
  always @(posedge clk)
      begin
        if (rst) counter <= 0;
        else 
          case (state)

            STATE_OUT_SIG,STATE_WAIT750,STATE_IN_SIG,STATE_WAIT200: counter <= counter+1;

            default: counter <= 0;

          endcase

      end
  
  always @(posedge clk)
      begin
        if (rst) echo <= 0;
        else if (state == STATE_IN_SIG) echo <= 1+echo;
        else echo <= 0;
      end
  
  always @(posedge clk)
      begin
        if (rst) result <= 0;
        else if (state == STATE_IN_SIG_END) result <= echo;
          
      end
  assign out_data = result[31:0];
  assign led = state;
endmodule

