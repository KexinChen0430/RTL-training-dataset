
module i2s_tx  #(parameter  WIDTH = 16)
  (input  wire clk,
   input  wire rst,
   input  wire [(-1)+WIDTH:0] input_l_tdata,
   input  wire [(-1)+WIDTH:0] input_r_tdata,
   input  wire input_tvalid,
   output wire input_tready,
   input  wire sck,
   input  wire ws,
   output wire sd);

  reg  [(-1)+WIDTH:0]  l_data_reg = 0;
  reg  [(-1)+WIDTH:0]  r_data_reg = 0;
  reg   l_data_valid_reg = 0;
  reg   r_data_valid_reg = 0;
  reg  [(-1)+WIDTH:0]  sreg = 0;
  reg  [$clog2(1+WIDTH)+(-1):0]  bit_cnt = 0;
  reg   last_sck = 0;
  reg   last_ws = 0;
  reg   sd_reg = 0;

  assign input_tready = ~l_data_valid_reg & ~r_data_valid_reg;
  assign sd = sd_reg;
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            l_data_reg <= 0;
            r_data_reg <= 0;
            l_data_valid_reg <= 0;
            r_data_valid_reg <= 0;
            sreg <= 0;
            bit_cnt <= 0;
            last_sck <= 0;
            last_ws <= 0;
            sd_reg <= 0;
          end
        else 
          begin
            if (input_tready & input_tvalid) 
              begin
                l_data_reg <= input_l_tdata;
                r_data_reg <= input_r_tdata;
                l_data_valid_reg <= 1;
                r_data_valid_reg <= 1;
              end
              
            last_sck <= sck;
            if (sck & ~last_sck) 
              begin
                last_ws <= ws;
                if (last_ws != ws) 
                  begin
                    bit_cnt <= WIDTH;
                    if (ws) 
                      begin
                        sreg <= r_data_reg;
                        r_data_valid_reg <= 0;
                      end
                    else 
                      begin
                        sreg <= l_data_reg;
                        l_data_valid_reg <= 0;
                      end
                  end
                  
              end
              
            if (last_sck & ~sck) 
              begin
                if (bit_cnt > 0) 
                  begin
                    bit_cnt <= (-1)+bit_cnt;
                    {sd_reg,sreg} <= {sreg[(-1)+WIDTH:0],1'b0};
                  end
                  
              end
              
          end
      end
endmodule

