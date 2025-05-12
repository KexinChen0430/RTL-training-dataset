
module axis2buffer  #(parameter  DWIDTH = 32, WIDTH = 8)
  (clk,rstn,alive_color,dead_color,S_AXIS_TDATA,S_AXIS_TVALID,
                   S_AXIS_TREADY,S_AXIS_TLAST,out_data,out_valid,out_ready,
                   num_reads,counter);

  input  clk;
  input  rstn;
  input  [DWIDTH-1:0] alive_color;
  input  [DWIDTH-1:0] dead_color;
  input  [DWIDTH-1:0] S_AXIS_TDATA;
  input  S_AXIS_TVALID;
  input  S_AXIS_TLAST;
  output reg S_AXIS_TREADY;
  output reg [(-1)+WIDTH:0] out_data;
  output reg out_valid;
  input  out_ready;
  output reg [31:0] num_reads;
  reg  next_num_reads;
  reg  state;
  reg  next_state;
  localparam  Wait = 0;
  localparam  Read = 1;
  reg  in_state;
  output reg [7:0] counter;
  reg  [7:0] next_counter;

  
  initial  
  begin
    state <= Read;
    out_data <= 0;
    counter <= 0;
    num_reads <= 0;
  end
  
  always @* 
      begin
        next_num_reads <= num_reads;
        if ((S_AXIS_TVALID == 1) && (state == Read)) 
          begin
            in_state <= (S_AXIS_TDATA == alive_color) ? 1'b1 : 1'b0;
          end
        else 
          begin
            in_state <= out_data[counter];
          end
        case (state)

          Wait: begin
                next_counter <= 0;
                S_AXIS_TREADY <= 0;
                out_valid <= 1;
                if (out_ready) 
                  begin
                    next_state <= Read;
                  end
                else 
                  begin
                    next_state <= Wait;
                  end
              end

          Read: begin
                S_AXIS_TREADY <= 1;
                next_state <= Read;
                out_valid <= 0;
                if (S_AXIS_TVALID == 1) 
                  begin
                    if (counter == ((-1)+WIDTH)) 
                      begin
                        next_counter <= 0;
                        next_state <= Wait;
                        next_num_reads <= num_reads+1;
                      end
                    else 
                      begin
                        next_counter <= 1+counter;
                      end
                  end
                else 
                  begin
                    next_counter <= counter;
                  end
              end

        endcase

      end
  
  always @(posedge clk)
      begin
        if (!rstn) 
          begin
            counter <= 8'h00;
            state <= Read;
            num_reads <= 0;
          end
        else 
          begin
            out_data[counter] <= in_state;
            state <= next_state;
            counter <= next_counter;
            num_reads <= next_num_reads;
          end
      end
endmodule

