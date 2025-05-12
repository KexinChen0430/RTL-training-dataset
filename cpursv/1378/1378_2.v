
module ctrl_reg_readback  #(parameter  CR_WIDTH = 6, N_CTRL_REGS = 64)
  (input  clk,
   input  rst,
   input  tx_en,
   input  tx_data_loaded,
   output reg tx_data_ready,
   output reg tx_complete,
   output reg [(-1)+CR_WIDTH:0] tx_cnt);

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            tx_cnt <= 0;
            tx_data_ready <= 0;
            tx_complete <= 0;
          end
        else 
          begin
            if (tx_en && !tx_complete) 
              begin
                if (tx_data_ready && tx_data_loaded) 
                  begin
                    tx_data_ready <= 0;
                    if (tx_cnt == (N_CTRL_REGS-1)) 
                      begin
                        tx_complete <= 1;
                        tx_cnt <= tx_cnt;
                      end
                    else 
                      begin
                        tx_cnt <= 1+tx_cnt;
                      end
                  end
                else 
                  begin
                    tx_data_ready <= (!tx_data_loaded && !tx_data_ready) ? 1 : tx_data_ready;
                  end
              end
            else if (!tx_en && tx_complete) 
              begin
                tx_cnt <= 0;
                tx_data_ready <= 0;
                tx_complete <= 0;
              end
            else 
              begin
                tx_data_ready <= tx_data_ready;
                tx_complete <= tx_complete;
                tx_cnt <= tx_cnt;
              end
          end
      end
endmodule

