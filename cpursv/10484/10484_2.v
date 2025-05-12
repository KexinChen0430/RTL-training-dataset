
module spi_master(input  data_in,
                  output clk_out,
                  output reg data_out,
                  output reg slave_select1_out,
                  output reg slave_select2_out,
                  output reg slave_select3_out,
                  input  clk_in,
                  input  rst_in);

  localparam  BYTE_SIZE = 8;
  localparam  BYTE_INDEX_SIZE = $clog2(BYTE_SIZE);
  reg  [BYTE_SIZE+(0-1):0] data_recv;
  reg  [BYTE_SIZE+(0-1):0] data_send;
  reg  [(0-1)+BYTE_INDEX_SIZE:0] send_iterator;
  reg  [(0-1)+BYTE_INDEX_SIZE:0] recv_iterator;
  reg  [1:0] state;
  parameter [1:0] 
       S_WAIT     = 2'd0,
       S_TRANSFER = 2'd1,
       S_DEASSERT = 2'd2;

  assign clk_out = clk_in;
  
  always @(posedge clk_in or posedge rst_in)
      begin
        if (rst_in == 1'b1) 
          begin
            state <= S_WAIT;
            data_recv <= 0;
            data_send <= 8'h55;
            data_out <= 1'bz;
            send_iterator <= 0;
            recv_iterator <= 0;
            slave_select1_out <= 1;
            slave_select2_out <= 1;
            slave_select3_out <= 1;
          end
        else 
          begin
            if (state == S_WAIT) 
              begin
                slave_select1_out <= 0;
                state <= S_TRANSFER;
              end
            else if (state == S_TRANSFER) 
              begin
                data_out <= data_send[send_iterator];
                if ((recv_iterator < (BYTE_SIZE+(0-1))) && 
                    (send_iterator > 0)) 
                  begin
                    data_recv[recv_iterator] <= data_in;
                    recv_iterator = 1+recv_iterator;
                  end
                  
                if (recv_iterator >= (BYTE_SIZE+(0-1))) 
                  begin
                    state <= S_DEASSERT;
                  end
                else send_iterator <= 1+send_iterator;
              end
            else if (state == S_DEASSERT) 
              begin
                data_recv[BYTE_SIZE+(0-1)] <= data_in;
                state <= S_WAIT;
                slave_select1_out <= 1;
                data_out <= 1'bz;
                send_iterator <= 0;
                recv_iterator <= 0;
                @(posedge clk_in)  ;
              end
            else 
              $display("ERROR: Unknown state: %d",state);
          end
      end
endmodule

