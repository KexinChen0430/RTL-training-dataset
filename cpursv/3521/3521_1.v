
module control_unit(input  wire clk,
                    input  wire rst_n,
                    input  wire [7:0] cmd,
                    input  wire rx_rdy,
                    input  wire tx_rdy,
                    output reg  cmd_oen = 1,
                    output reg  data_wen = 1,
                    output reg [7:0]  data = 0,
                    input  wire [7:0] servo_angle,
                    output reg [7:0] start_angle,
                    output reg [7:0] end_angle,
                    input  wire servo_cycle_done,
                    input  wire sonar_ready,
                    input  wire [7:0] sonar_distance,
                    output reg  sonar_measure = 0);

  reg  [7:0]  distance = 0;
  parameter  AUTO_MODE = 1'b0;
  parameter  MANUAL_MODE = 1'b1;
  reg   mode = AUTO_MODE;
  parameter  IDLE = 4'h0;
  parameter  FETCH_CMD = 4'h1;
  parameter  FETCH_DATA_PRE = 4'h2;
  parameter  FETCH_DATA = 4'h3;
  parameter  WAIT_SERVO_DONE = 4'h4;
  parameter  START_MEASURE = 4'h5;
  parameter  MEASURE = 4'h6;
  parameter  WAIT_TX_RDY = 4'h7;
  parameter  SEND_DATA = 4'h8;
  parameter  SEND_DATA_POST = 4'h9;
  reg  [3:0]  state = IDLE;
  reg  [3:0]  next_state = IDLE;
  reg   send_data_type = 0;
  parameter  MANUAL_CMD = 4'h0;
  parameter  SET_ANGLE_CMD = 2'h0;
  parameter  SET_MODE_CMD = 2'h1;
  parameter  MEASURE_CMD = 2'h2;

  
  always @(posedge clk or negedge rst_n)
      begin
        if (~rst_n) 
          begin
            state = IDLE;
          end
        else 
          begin
            state = next_state;
          end
      end
  
  always @(posedge clk or negedge rst_n)
      begin
        if (~rst_n) 
          begin
            next_state = IDLE;
          end
        else 
          begin
            case (state)

              IDLE: begin
                    if (rx_rdy) 
                      begin
                        next_state = FETCH_CMD;
                      end
                    else if (mode == AUTO_MODE) 
                      begin
                        next_state = WAIT_SERVO_DONE;
                      end
                      
                  end

              FETCH_CMD: begin
                    case (cmd[7:4])

                      MANUAL_CMD: begin
                            case (cmd[3:2])

                              SET_ANGLE_CMD: begin
                                    next_state = FETCH_DATA_PRE;
                                  end

                              SET_MODE_CMD: begin
                                    next_state = IDLE;
                                  end

                              MEASURE_CMD: begin
                                    next_state = START_MEASURE;
                                  end

                            endcase

                          end

                      default: begin
                            next_state = IDLE;
                          end

                    endcase

                  end

              FETCH_DATA_PRE: begin
                    if (rx_rdy) 
                      begin
                        next_state = FETCH_DATA;
                      end
                      
                  end

              FETCH_DATA: begin
                    next_state = IDLE;
                  end

              WAIT_SERVO_DONE: begin
                    if (servo_cycle_done) 
                      begin
                        next_state = START_MEASURE;
                      end
                      
                  end

              START_MEASURE: begin
                    next_state = MEASURE;
                  end

              MEASURE: begin
                    if (sonar_ready) 
                      begin
                        next_state = WAIT_TX_RDY;
                      end
                      
                  end

              WAIT_TX_RDY: begin
                    if (tx_rdy) 
                      begin
                        next_state = SEND_DATA;
                      end
                      
                  end

              SEND_DATA: begin
                    next_state = SEND_DATA_POST;
                  end

              SEND_DATA_POST: begin
                    case (send_data_type)

                      0: next_state = WAIT_TX_RDY;

                      1: next_state = IDLE;

                    endcase

                  end

            endcase

          end
      end
  
  always @(posedge clk or negedge rst_n)
      begin
        if (~rst_n) 
          begin
            mode = AUTO_MODE;
            cmd_oen = 1;
            data_wen = 1;
            data = 0;
            sonar_measure = 0;
            start_angle = 8'h00;
            end_angle = 8'hFE;
          end
        else 
          begin
            case (state)

              IDLE: begin
                    cmd_oen = 1;
                    data_wen = 1;
                    sonar_measure = 0;
                  end

              FETCH_CMD: begin
                    cmd_oen = 0;
                    case (cmd[7:4])

                      MANUAL_CMD: begin
                            case (cmd[3:2])

                              SET_MODE_CMD: begin
                                    mode = cmd[0];
                                  end

                            endcase

                          end

                      default: begin
                            if (cmd[3:0] < cmd[7:4]) 
                              begin
                                start_angle = {cmd[3:0],4'h0};
                                end_angle = {cmd[7:4],4'h0};
                              end
                            else 
                              begin
                                start_angle = {cmd[7:4],4'h0};
                                end_angle = {cmd[3:0],4'h0};
                              end
                          end

                    endcase

                  end

              FETCH_DATA_PRE: begin
                    cmd_oen = 1;
                  end

              FETCH_DATA: begin
                    start_angle = cmd;
                    end_angle = cmd;
                    cmd_oen = 0;
                  end

              WAIT_SERVO_DONE: begin

                  end

              START_MEASURE: begin
                    sonar_measure = 1;
                  end

              MEASURE: begin
                    sonar_measure = 0;
                    distance = sonar_distance;
                  end

              WAIT_TX_RDY: begin
                    if (tx_rdy) 
                      begin
                        case (send_data_type)

                          0: data = {distance[7:1],1'b0};

                          1: data = {servo_angle[7:1],1'b1};

                        endcase

                      end
                      
                  end

              SEND_DATA: begin
                    data_wen = 0;
                  end

              SEND_DATA_POST: begin
                    data_wen = 1;
                    send_data_type = !send_data_type;
                  end

            endcase

          end
      end
endmodule

