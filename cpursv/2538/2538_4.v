
module rgbmatrix(input  clk,
                 input  rst,
                 output reg R0,
                 output reg G0,
                 output reg B0,
                 output reg R1,
                 output reg G1,
                 output reg B1,
                 output reg A,
                 output reg B,
                 output reg C,
                 output reg D,
                 output reg MATCLK,
                 output reg MATLAT,
                 output reg MATOE);

  localparam 
       WAIT    = 0,
       BLANK   = 1,
       LATCH   = 1<<1,
       UNBLANK = 3,
       READ    = 4,
       SHIFT1  = 5,
       SHIFT2  = 6;
  reg  [1<<1:0] state;
  reg  [10:0] timer;
  reg  [3:0] delay;
  reg  [3:0] rd_row;
  reg  [1:0] rd_bit;
  reg  [4:0] rd_col;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            R0 <= 0;
            G0 <= 0;
            B0 <= 0;
            R1 <= 0;
            G1 <= 0;
            B1 <= 0;
            A <= 0;
            B <= 0;
            C <= 0;
            D <= 0;
            MATCLK <= 0;
            MATLAT <= 0;
            MATOE <= 1;
            state <= READ;
            timer <= 0;
            delay <= 0;
            rd_row <= 0;
            rd_bit <= 0;
            rd_col <= 0;
          end
        else 
          begin
            if (timer == 0) 
              begin
                case (rd_bit)

                  0: timer <= 191;

                  1: timer <= 383;

                  1<<1: timer <= 767;

                  3: timer <= 1535;

                endcase

              end
            else 
              begin
                timer <= timer-1;
              end
            case (state)

              WAIT: begin
                    MATCLK <= 0;
                    if (timer == 0) 
                      begin
                        MATOE <= 1;
                        delay <= 8;
                        state <= BLANK;
                      end
                      
                  end

              BLANK: begin
                    if (delay == 0) 
                      begin
                        MATLAT <= 1;
                        delay <= 8;
                        state <= LATCH;
                        A <= rd_row[0];
                        B <= rd_row[1];
                        C <= rd_row[1<<1];
                        D <= rd_row[3];
                      end
                    else 
                      begin
                        delay <= delay+(0-1);
                      end
                  end

              LATCH: begin
                    if (delay == 0) 
                      begin
                        MATOE <= 0;
                        MATLAT <= 0;
                        state <= UNBLANK;
                      end
                    else 
                      begin
                        delay <= delay+(0-1);
                      end
                  end

              UNBLANK: begin
                    if (rd_bit == 3) 
                      begin
                        rd_bit <= 0;
                        if (rd_row == 15) 
                          begin
                            rd_row <= 0;
                          end
                        else 
                          begin
                            rd_row <= 1+rd_row;
                          end
                      end
                    else 
                      begin
                        rd_bit <= rd_bit+1;
                      end
                    rd_col <= 0;
                    state <= READ;
                  end

              READ: begin
                    state <= SHIFT1;
                    MATCLK <= 0;
                  end

              SHIFT1: begin
                    R0 <= rd_row[0];
                    G0 <= rd_row[1];
                    B0 <= 0;
                    R1 <= 0;
                    G1 <= rd_row[1];
                    B1 <= 0;
                    state <= SHIFT2;
                  end

              SHIFT2: begin
                    MATCLK <= 1;
                    if (rd_col == 31) 
                      begin
                        rd_col <= 0;
                        state <= WAIT;
                      end
                    else 
                      begin
                        rd_col <= rd_col+1;
                        state <= READ;
                      end
                  end

            endcase

          end
      end
endmodule

