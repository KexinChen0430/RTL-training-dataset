
module testbench(input  clk_i,
                 input  rst_i);

  localparam  AUB = 8;
  localparam  AU_IN_DATA = DATA_WIDTH*(1/AUB);
  reg  [1:0] master_state;
  parameter [1:0] 
       S_MASTER_INIT_WRITE = 2'd0,
       S_MASTER_WAIT_WRITE = 2'd1,
       S_MASTER_INIT_READ  = 2'd2,
       S_MASTER_WAIT_READ  = 2'd3;
  reg  [DATA_WIDTH+(0-1):0] test_values[DATA_COUNT-1:0];
  reg  [DATA_COUNT:0] value_iterator;

  
  always @(posedge clk_i or posedge rst_i)
      begin
        if (rst_i == 1'b1) 
          begin
            test_values[0] = 32'h00000000;
            test_values[1] = 32'h10001111;
            test_values[2] = 32'h20002222;
            test_values[3] = 32'h30003333;
            test_values[4] = 32'h40004444;
            test_values[5] = 32'h50005555;
            test_values[6] = 32'h60006666;
            test_values[7] = 32'h70007777;
            master_state <= S_MASTER_INIT_WRITE;
            mem_address_o <= 0;
            mem_data_o <= 0;
            mem_master_rdy <= 0;
            mem_we_o <= 0;
            value_iterator <= 0;
          end
        else 
          begin
            if (master_state == S_MASTER_INIT_WRITE) 
              begin
                mem_master_rdy <= 1;
                mem_we_o <= 1;
                mem_data_o <= test_values[value_iterator];
                master_state <= S_MASTER_WAIT_WRITE;
                mem_address_o <= (value_iterator*AU_IN_DATA)+BASE_ADDRESS;
              end
            else if (master_state == S_MASTER_WAIT_WRITE) 
              begin
                mem_master_rdy <= 0;
                if (mem_slave_rdy == 1) 
                  begin
                    master_state <= S_MASTER_INIT_READ;
                  end
                  
              end
            else if (master_state == S_MASTER_INIT_READ) 
              begin
                mem_master_rdy <= 1;
                mem_we_o <= 0;
                master_state <= S_MASTER_WAIT_READ;
                mem_address_o <= (value_iterator*AU_IN_DATA)+BASE_ADDRESS;
              end
            else if (master_state == S_MASTER_WAIT_READ) 
              begin
                mem_master_rdy <= 0;
                if (mem_slave_rdy == 1) 
                  begin
                    master_state <= S_MASTER_INIT_WRITE;
                    if (test_values[value_iterator] != mem_data_i) 
                      begin
                        $display("ERROR: Wrong answer from wrapper: %X Expected: %X",
                                 mem_data_i,test_values[value_iterator]);
                        $stop;
                      end
                      
                    if (value_iterator >= DATA_COUNT) 
                      begin
                        $display("SIMULATION COMPLETE");
                        $stop;
                      end
                      
                    value_iterator <= 1+value_iterator;
                  end
                  
              end
            else 
              $display("ERROR: Unkown master_state: %d",master_state);
          end
      end
  integer memory_index;

  reg  slave_state;

  parameter  S_WAIT = 1'd0, S_DEASSERT = 1'd1;

  localparam  MEMORY_SIZE = DATA_COUNT*4;

  reg  [AUB-1:0] memory[MEMORY_SIZE+(0-1):0];

  
  always @(posedge clk_i or posedge rst_i)
      begin
        if (rst_i == 1'b1) 
          begin
            wb_ack_o <= 0;
            wb_dat_o <= 0;
            wb_err_o <= 0;
            slave_state <= S_WAIT;
          end
        else 
          begin
            if (slave_state == S_WAIT) 
              begin
                if ((wb_stb_i == 1) && (wb_cyc_i == 1)) 
                  begin
                    if ((wb_adr_i >= BASE_ADDRESS) && 
                        (wb_adr_i < (MEMORY_SIZE+BASE_ADDRESS))) 
                      begin
                        wb_ack_o <= 1;
                        if (wb_we_i == 1) 
                          begin
                            for (memory_index = 0; memory_index < AU_IN_DATA; memory_index = memory_index+1)
                                begin
                                  memory[(0-BASE_ADDRESS)+(wb_adr_i+memory_index)] <= wb_dat_i[memory_index*AUB +: AUB];
                                end
                          end
                        else 
                          begin
                            for (memory_index = 0; memory_index < AU_IN_DATA; memory_index = memory_index+1)
                                begin
                                  wb_dat_o[memory_index*AUB +: AUB] <= memory[(0-BASE_ADDRESS)+(wb_adr_i+memory_index)];
                                end
                          end
                      end
                    else 
                      begin
                        wb_err_o <= 1;
                      end
                    slave_state <= S_DEASSERT;
                  end
                  
              end
            else if (slave_state == S_DEASSERT) 
              begin
                wb_ack_o <= 0;
                wb_err_o <= 0;
                slave_state <= S_WAIT;
              end
            else 
              $display("ERROR: Unkown slave_state: %d",slave_state);
          end
      end
endmodule

