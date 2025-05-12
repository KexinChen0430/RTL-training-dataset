
module fillbox_act(input  wire [27:0] vram,
                   input  wire [9:0] width,
                   input  wire [9:0] height,
                   input  wire start,
                   output wire done,
                   input  wire clk,
                   input  wire bready,
                   output reg [27:0] awaddr,
                   output reg burst_start,
                   output reg [7:0] awlen,
                   output reg [3:0] wstrb);

  parameter  IDLE = 2'h0, START = 2'h1, WAIT = 2'h2;
  localparam  SCREEN_WIDTH = 28'd1280;
  reg  [27:0]  vram_y = 0;
  reg  [10:0]  offset = 0;
  reg  [10:0]  delta = 0;
  reg  [9:0]  width_work = 0;
  reg  [9:0]  height_work = 0;
  reg  [9:0]  expected_count = 0;
  reg  [9:0]  real_count = 0;
  reg  [1:0]  state_x = IDLE, state_y = IDLE;
  reg   start_x = 0;
  reg   end_x = 0;
  reg   done_ff1 = 0;
  reg   done_ff2 = 0;
  wire [27:0]  awaddr_tmp = vram_y+{17'b0,offset};

  assign done = done_ff1 && ~done_ff2;
  
  always @(posedge clk)
      begin
        done_ff2 <= done_ff1;
        done_ff1 <= (width_work == 10'd0) && (height_work == 10'd0) && 
                   (expected_count == real_count);
        awaddr <= {awaddr_tmp[27:1<<1],2'b0};
      end
  
  always @(posedge clk)
      begin
        if (start_x == 'b0) real_count <= 10'd0;
        else if (bready) real_count <= 10'd1+real_count;
          
      end
  
  always @(posedge clk)
      begin
        case (state_y)

          IDLE: begin
                if (start) 
                  begin
                    state_y <= START;
                    height_work <= height;
                    vram_y <= vram;
                  end
                  
                start_x <= 'b0;
              end

          START: begin
                if (height_work == 10'd0) 
                  begin
                    state_y <= IDLE;
                  end
                else 
                  begin
                    state_y <= WAIT;
                    start_x <= 'b1;
                  end
              end

          WAIT: begin
                if (end_x) 
                  begin
                    state_y <= START;
                    height_work <= height_work-10'd1;
                    vram_y <= vram_y+SCREEN_WIDTH;
                    start_x <= 'b0;
                  end
                  
              end

          default: begin
                state_y <= IDLE;
              end

        endcase

      end
  
  always @(posedge clk)
      begin
        if (start_x == 'b0) 
          begin
            end_x <= 'b0;
            expected_count = 10'd0;
            width_work <= 10'd0;
            offset <= 11'd0;
            delta <= 11'd0;
            burst_start <= 'b0;
            awlen <= 8'd0;
            wstrb <= 4'b0000;
            state_x <= IDLE;
          end
        else 
          begin
            case (state_x)

              IDLE: begin
                    end_x <= 'b0;
                    expected_count <= 10'd0;
                    width_work <= width;
                    offset <= 11'd0;
                    delta <= 11'd0;
                    burst_start <= 'b0;
                    awlen <= 8'd0;
                    wstrb <= 4'b0000;
                    state_x <= START;
                  end

              START: begin
                    if (width_work == 10'd0) 
                      begin
                        end_x <= 'b1;
                        state_x <= IDLE;
                      end
                    else 
                      begin
                        end_x <= 'b0;
                        expected_count <= 10'd1+expected_count;
                        burst_start <= 'b1;
                        state_x <= WAIT;
                      end
                  end

              WAIT: begin
                    if (bready) 
                      begin
                        offset <= delta+offset;
                        delta <= 11'd0;
                        state_x <= START;
                      end
                      
                    burst_start <= 'b0;
                    end_x <= 'b0;
                  end

              default: begin
                    state_x <= IDLE;
                  end

            endcase

          end
      end
endmodule

