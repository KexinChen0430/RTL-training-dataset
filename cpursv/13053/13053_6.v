
module wb_master  #(parameter 
       ADDR_WIDTH    = 16,
       DATA_COUNT    = 8,
       DATA_WIDTH    = 32,
       BASE_ADDRESS  = 'h0F00,
       SEND_ERR_ADDR = 0)
  (input  ack_i,
   input  [(-1)+DATA_WIDTH:0] dat_i,
   input  err_i,
   output reg [ADDR_WIDTH+(-1):0] adr_o,
   output reg cyc_o,
   output reg [(-1)+DATA_WIDTH:0] dat_o,
   output reg stb_o,
   output reg we_o,
   input  clk_i,
   input  rst_i,
   input  start,
   output reg done);

  localparam  AUB = 8;
  localparam  AU_IN_DATA = DATA_WIDTH*(1/AUB);
  localparam  MAX_WAIT = 1000;
  reg  [(-1)+DATA_WIDTH:0] register_file[(-1)+DATA_COUNT:0];
  reg  [$clog2(DATA_COUNT)-1:0] iterator;
  reg  [1<<<1:0] state;
  integer index;
  integer wait_count;
  parameter [1<<<1:0] 
       S_START          = 3'd0,
       S_BOGUS_INIT     = 3'd1,
       S_WAIT_BOGUS_ACK = 3'd2,
       S_WRITE_INIT     = 3'd3,
       S_WAIT_WRITE_ACK = 3'd4,
       S_READ_INIT      = 3'd5,
       S_WAIT_READ_ACK  = 3'd6;

  
  always @(posedge clk_i or posedge rst_i)
      begin
        if (rst_i == 1'b1) 
          begin
            for (index = 0; index < DATA_COUNT; index = index+1)
                begin
                  register_file[index] = {AU_IN_DATA{index[AUB+(-1):0]}};
                end
            state <= S_START;
            dat_o <= 0;
            cyc_o <= 0;
            stb_o <= 0;
            we_o <= 0;
            done <= 0;
            iterator <= 0;
            adr_o <= 0;
            wait_count = 0;
          end
        else 
          begin
            case (state)

              S_START: begin
                    if (SEND_ERR_ADDR) 
                      begin
                        state <= S_BOGUS_INIT;
                      end
                    else 
                      begin
                        state <= S_WRITE_INIT;
                      end
                    done <= 0;
                    iterator <= 0;
                  end

              S_BOGUS_INIT: begin
                    cyc_o <= 1;
                    stb_o <= 1;
                    we_o <= 1;
                    adr_o <= BASE_ADDRESS-10;
                    state <= S_WAIT_BOGUS_ACK;
                    wait_count = 0;
                  end

              S_WAIT_BOGUS_ACK: begin
                    if (err_i == 1'b1) 
                      begin
                        cyc_o <= 0;
                        stb_o <= 0;
                        we_o <= 0;
                        state <= S_WRITE_INIT;
                      end
                      
                    if (wait_count > MAX_WAIT) 
                      $stop;
                      
                    wait_count = wait_count+1;
                  end

              S_WRITE_INIT: begin
                    cyc_o <= 1;
                    stb_o <= 1;
                    we_o <= 1;
                    dat_o <= register_file[iterator];
                    adr_o <= BASE_ADDRESS+(iterator*AU_IN_DATA);
                    state <= S_WAIT_WRITE_ACK;
                    wait_count = 0;
                  end

              S_WAIT_WRITE_ACK: begin
                    if (ack_i == 1'b1) 
                      begin
                        cyc_o <= 0;
                        stb_o <= 0;
                        we_o <= 0;
                        state <= S_READ_INIT;
                      end
                      
                    if (wait_count > MAX_WAIT) 
                      $stop;
                      
                    wait_count = wait_count+1;
                  end

              S_READ_INIT: begin
                    cyc_o <= 1;
                    stb_o <= 1;
                    we_o <= 0;
                    state <= S_WAIT_READ_ACK;
                  end

              S_WAIT_READ_ACK: begin
                    if (ack_i == 1'b1) 
                      begin
                        cyc_o <= 0;
                        stb_o <= 0;
                        we_o <= 0;
                        if (register_file[iterator] != dat_i) 
                          begin
                            $display("ERROR: Wrong answer from slave: %X",
                                     dat_i);
                            $stop;
                          end
                          
                        if (iterator == ((-1)+DATA_COUNT)) 
                          begin
                            done <= 1;
                            $stop;
                          end
                        else 
                          begin
                            iterator <= 1+iterator;
                            state <= S_WRITE_INIT;
                            wait_count = 0;
                          end
                      end
                      
                    if (wait_count > MAX_WAIT) 
                      $stop;
                      
                    wait_count = wait_count+1;
                  end

              default: begin
                    $display("ERROR: Unknown state: %d",state);
                  end

            endcase

          end
      end
endmodule

