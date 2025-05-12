
module wb_master  #(parameter 
       BASE_ADDRESS = 0,
       DATA_WIDTH   = 16,
       ADDR_WIDTH   = 16,
       DATA_COUNT   = 16,
       AU_IN_DATA   = 1)
  (input  clk,
   input  rst,
   input  start,
   output reg done,
   output reg cyc_o,
   output reg stb_o,
   input  ack_i,
   output reg we_o,
   output reg [DATA_WIDTH-1:0] dat_o,
   input  [DATA_WIDTH-1:0] dat_i,
   output reg [(0-1)+ADDR_WIDTH:0] adr_o);

  reg  [DATA_WIDTH-1:0] dat[0:(0-1)+DATA_COUNT];
  reg  [3:0] iterator;
  reg  start_old;
  reg  [1<<1:0] state;
  parameter [1<<1:0] 
       S_WAIT_START     = 3'd0,
       S_WRITE_INIT     = 3'd1,
       S_WAIT_WRITE_ACK = 3'd2,
       S_READ_INIT      = 3'd3,
       S_WAIT_READ_ACK  = 3'd4;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst == 1'b0) 
          begin
            dat[0] = 32'h00000000;
            dat[1] = 32'h10001111;
            dat[1<<1] = 32'h20002222;
            dat[3] = 32'h30003333;
            dat[4] = 32'h40004444;
            dat[5] = 32'h50005555;
            dat[6] = 32'h60006666;
            dat[7] = 32'h70007777;
            dat[8] = 32'h80008888;
            dat[9] = 32'h90009999;
            dat[10] = 32'hA000AAAA;
            dat[11] = 32'hB000BBBB;
            dat[12] = 32'hC000CCCC;
            dat[13] = 32'hD000DDDD;
            dat[14] = 32'hE000EEEE;
            dat[15] = 32'hF000FFFF;
            state <= S_WAIT_START;
            dat_o <= 0;
            cyc_o <= 0;
            stb_o <= 0;
            we_o <= 0;
            done <= 0;
            iterator <= 0;
            adr_o <= 0;
            start_old <= 0;
          end
        else 
          begin
            start_old <= start;
            if (state == S_WAIT_START) 
              begin
                if ((start_old == 1'b1) && (start == 1'b0)) 
                  begin
                    state <= S_WRITE_INIT;
                    done <= 0;
                    iterator <= 0;
                  end
                  
              end
            else if (state == S_WRITE_INIT) 
              begin
                cyc_o <= 1;
                stb_o <= 1;
                we_o <= 1;
                dat_o <= dat[iterator];
                adr_o <= (AU_IN_DATA*iterator)+BASE_ADDRESS;
                state <= S_WAIT_WRITE_ACK;
              end
            else if (state == S_WAIT_WRITE_ACK) 
              begin
                if (ack_i == 1'b1) 
                  begin
                    cyc_o <= 0;
                    stb_o <= 0;
                    we_o <= 0;
                    state <= S_READ_INIT;
                  end
                  
              end
            else if (state == S_READ_INIT) 
              begin
                cyc_o <= 1;
                stb_o <= 1;
                we_o <= 0;
                state <= S_WAIT_READ_ACK;
              end
            else if (state == S_WAIT_READ_ACK) 
              begin
                if (ack_i == 1'b1) 
                  begin
                    cyc_o <= 0;
                    stb_o <= 0;
                    we_o <= 0;
                    if (dat[iterator] != dat_i) 
                      begin
                        $display("ERROR: Wrong answer from slave: %X",
                                 dat_i);
                        $stop;
                      end
                      
                    if (iterator == ((0-1)+DATA_COUNT)) 
                      begin
                        done <= 1;
                        state <= S_WAIT_START;
                      end
                    else 
                      begin
                        iterator <= iterator+1;
                        state <= S_WRITE_INIT;
                      end
                  end
                  
              end
            else 
              $display("ERROR: Unkown state: %d",state);
          end
      end
endmodule

