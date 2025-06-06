
module SPI_IF_accel(input  clk,
                    input  rst,
                    input  [6:0] mpu_address,
                    input  [7:0] mpu_wr_data,
                    input  mpu_rd_wr_sel,
                    input  start,
                    output busy,
                    output SPI_SS_a,
                    output SPI_CK_a,
                    output SPI_DO_a,
                    input  SPI_DI_a,
                    output [7:0] mpu_rd_data);

  reg  [7:0] mpu_rd_data_buff;
  reg  [7:0] SPIstate;
  reg  [11:0] counter;
  reg  MPUclk;
  reg  do_reg;
  reg  ss_reg;
  reg  ck_reg;
  reg  busy_bf;
  reg  [4:0] i;
  reg  [4:0] j;
  parameter  SPI_HALF_CLK = 50;
  parameter  SPI_CLK = SPI_HALF_CLK*1<<<1;
  wire  halfCLKpassed = counter == ((0-1)+SPI_HALF_CLK);

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            counter <= 0;
            MPUclk <= 0;
          end
        else 
          begin
            if (start == 1) 
              begin
                counter <= 0;
                MPUclk <= 1;
              end
            else if (halfCLKpassed) 
              begin
                counter <= 0;
                MPUclk <= ~MPUclk;
              end
            else 
              begin
                counter <= 1+counter;
              end
          end
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            SPIstate <= 0;
          end
        else 
          begin
            case (SPIstate)

              0: if (start == 1) SPIstate <= 1;
                    

              1: SPIstate <= 3;

              3: begin
                    if ((mpu_rd_wr_sel == 1) && (i == 0)) SPIstate <= 4;
                      
                    if ((i == 0) && (mpu_rd_wr_sel == 0)) SPIstate <= 5;
                      
                  end

              4: if (j == 0) SPIstate <= 6;
                    

              5: if (j == 0) SPIstate <= 6;
                    

              6: if (halfCLKpassed) SPIstate <= 7;
                    

              7: SPIstate <= 0;

            endcase

          end
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            do_reg <= 0;
            ck_reg <= 1;
            ss_reg <= 1;
            busy_bf <= 0;
            mpu_rd_data_buff <= 0;
            i <= 16;
            j <= 17;
          end
        else 
          begin
            case (SPIstate)

              0: begin
                    do_reg <= 0;
                    ss_reg <= 1;
                    busy_bf <= 0;
                    i <= 16;
                    j <= 17;
                  end

              1: begin
                    busy_bf <= 1;
                    ss_reg <= 0;
                  end

              3: begin
                    if (halfCLKpassed) 
                      begin
                        case (i)

                          16: do_reg <= mpu_rd_wr_sel;

                          14: do_reg <= mpu_address[6];

                          12: do_reg <= mpu_address[5];

                          10: do_reg <= mpu_address[4];

                          8: do_reg <= mpu_address[3];

                          6: do_reg <= mpu_address[1<<<1];

                          4: do_reg <= mpu_address[1];

                          1<<<1: do_reg <= mpu_address[0];

                          0: do_reg <= 0;

                        endcase

                        if (i != 0) i <= (0-1)+i;
                          
                      end
                      
                  end

              4: begin
                    if (halfCLKpassed) 
                      begin
                        case (j)

                          16: mpu_rd_data_buff[7] <= SPI_DI_a;

                          14: mpu_rd_data_buff[6] <= SPI_DI_a;

                          12: mpu_rd_data_buff[5] <= SPI_DI_a;

                          10: mpu_rd_data_buff[4] <= SPI_DI_a;

                          8: mpu_rd_data_buff[3] <= SPI_DI_a;

                          6: mpu_rd_data_buff[1<<<1] <= SPI_DI_a;

                          4: mpu_rd_data_buff[1] <= SPI_DI_a;

                          1<<<1: mpu_rd_data_buff[0] <= SPI_DI_a;

                        endcase

                        if (j != 0) j <= (0-1)+j;
                          
                      end
                      
                  end

              5: begin
                    if (halfCLKpassed) 
                      begin
                        case (j)

                          16: do_reg <= mpu_wr_data[7];

                          14: do_reg <= mpu_wr_data[6];

                          12: do_reg <= mpu_wr_data[5];

                          10: do_reg <= mpu_wr_data[4];

                          8: do_reg <= mpu_wr_data[3];

                          6: do_reg <= mpu_wr_data[1<<<1];

                          4: do_reg <= mpu_wr_data[1];

                          1<<<1: do_reg <= mpu_wr_data[0];

                          0: do_reg <= 0;

                        endcase

                        if (j != 0) j <= (0-1)+j;
                          
                      end
                      
                  end

              6: begin
                    ck_reg <= 1;
                    do_reg <= 0;
                    ss_reg <= 1;
                  end

              7: begin

                  end

            endcase

          end
      end
  assign SPI_DO_a = do_reg;
  assign SPI_CK_a = MPUclk | ss_reg;
  assign SPI_SS_a = ss_reg;
  assign busy = busy_bf | start;
  assign mpu_rd_data = mpu_rd_data_buff;
endmodule

