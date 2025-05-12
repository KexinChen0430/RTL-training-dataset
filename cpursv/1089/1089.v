
module kernel_clock_0_slave_FSM(input  master_read_done_token,
                                input  master_write_done_token,
                                input  slave_clk,
                                input  slave_read,
                                input  slave_reset_n,
                                input  slave_write,
                                output reg slave_read_request,
                                output reg slave_waitrequest,
                                output reg slave_write_request);

  reg  [2:0] next_slave_state;
  reg  next_slave_read_request;
  reg  next_slave_write_request;
  reg  [2:0] slave_state;

  
  always @(posedge slave_clk or negedge slave_reset_n)
      begin
        if (!slave_reset_n) 
          begin
            slave_read_request <= 0;
          end
        else 
          begin
            slave_read_request <= next_slave_read_request;
          end
      end
  
  always @(posedge slave_clk or negedge slave_reset_n)
      begin
        if (!slave_reset_n) 
          begin
            slave_write_request <= 0;
          end
        else 
          begin
            slave_write_request <= next_slave_write_request;
          end
      end
  
  always @(posedge slave_clk or negedge slave_reset_n)
      begin
        if (!slave_reset_n) 
          begin
            slave_state <= 3'b001;
          end
        else 
          begin
            slave_state <= next_slave_state;
          end
      end
  
  always @(*)
      begin
        next_slave_read_request = slave_read_request;
        next_slave_write_request = slave_write_request;
        next_slave_state = slave_state;
        slave_waitrequest = 0;
        case (slave_state)

          3'b001: begin
                if (slave_read) 
                  begin
                    next_slave_state = 3'b010;
                    slave_waitrequest = 1;
                    next_slave_read_request = !slave_read_request;
                  end
                else if (slave_write) 
                  begin
                    next_slave_state = 3'b100;
                    slave_waitrequest = 1;
                    next_slave_write_request = !slave_write_request;
                  end
                  
              end

          3'b010: begin
                if (master_read_done_token) 
                  begin
                    next_slave_state = 3'b001;
                  end
                else 
                  begin
                    slave_waitrequest = 1;
                  end
              end

          3'b100: begin
                if (master_write_done_token) 
                  begin
                    next_slave_state = 3'b001;
                  end
                else 
                  begin
                    slave_waitrequest = 1;
                  end
              end

          default: begin
                next_slave_state = 3'b001;
              end

        endcase

      end
endmodule

