
module uart_tx  #(parameter  DATA_WIDTH = 8)
  (input  wire clk,
   input  wire rst,
   input  wire [(-1)+DATA_WIDTH:0] s_axis_tdata,
   input  wire s_axis_tvalid,
   output wire s_axis_tready,
   output wire txd,
   output wire busy,
   input  wire [15:0] prescale);

  reg   s_axis_tready_reg = 0;
  reg   txd_reg = 1;
  reg   busy_reg = 0;
  reg  [DATA_WIDTH:0]  data_reg = 0;
  reg  [18:0]  prescale_reg = 0;
  reg  [3:0]  bit_cnt = 0;

  assign s_axis_tready = s_axis_tready_reg;
  assign txd = txd_reg;
  assign busy = busy_reg;
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            s_axis_tready_reg <= 0;
            txd_reg <= 1;
            prescale_reg <= 0;
            bit_cnt <= 0;
            busy_reg <= 0;
          end
        else 
          begin
            if (prescale_reg > 0) 
              begin
                s_axis_tready_reg <= 0;
                prescale_reg <= prescale_reg-1;
              end
            else if (bit_cnt == 0) 
              begin
                s_axis_tready_reg <= 1;
                busy_reg <= 0;
                if (s_axis_tvalid) 
                  begin
                    s_axis_tready_reg <= !s_axis_tready_reg;
                    prescale_reg <= (-1)+prescale<<<3;
                    bit_cnt <= DATA_WIDTH+1;
                    data_reg <= {1'b1,s_axis_tdata};
                    txd_reg <= 0;
                    busy_reg <= 1;
                  end
                  
              end
            else 
              begin
                if (bit_cnt > 1) 
                  begin
                    bit_cnt <= bit_cnt-1;
                    prescale_reg <= (-1)+prescale<<<3;
                    {data_reg,txd_reg} <= {1'b0,data_reg};
                  end
                else if (bit_cnt == 1) 
                  begin
                    bit_cnt <= bit_cnt-1;
                    prescale_reg <= prescale<<<3;
                    txd_reg <= 1;
                  end
                  
              end
          end
      end
endmodule

