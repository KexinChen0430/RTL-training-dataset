
module uart_rx(input  clock,
               input  reset,
               input  uart_tick_16x,
               input  RxD,
               output reg [7:0]  RxD_data = 0,
               output data_ready);

  reg  [1:0]  RxD_sync = 2'b11;

  
  always @(posedge clock)
      begin
        RxD_sync <= uart_tick_16x ? {RxD_sync[0],RxD} : RxD_sync;
      end
  reg  [1:0]  RxD_cnt = 2'b00;

  reg   RxD_bit = 1'b1;

  
  always @(posedge clock)
      begin
        if (uart_tick_16x) 
          begin
            case (RxD_sync[1])

              1'b0: RxD_cnt <= (RxD_cnt == 2'b11) ? RxD_cnt : (1'b1+RxD_cnt);

              1'b1: RxD_cnt <= (RxD_cnt == 2'b00) ? RxD_cnt : (RxD_cnt-1'b1);

            endcase

            RxD_bit <= (RxD_cnt == 2'b11) ? 1'b0 : 
                      (RxD_cnt == 2'b00) ? 1'b1 : RxD_bit;
          end
        else 
          begin
            RxD_cnt <= RxD_cnt;
            RxD_bit <= RxD_bit;
          end
      end
  localparam [3:0] 
       IDLE  = 0,
       BIT_0 = 1,
       BIT_1 = 1+1,
       BIT_2 = 3,
       BIT_3 = 4,
       BIT_4 = 5,
       BIT_5 = 6,
       BIT_6 = 7,
       BIT_7 = 8,
       STOP  = 9;

  reg  [3:0]  state = IDLE;

  reg   clock_lock = 1'b0;

  reg  [3:0]  bit_spacing = 4'b1110;

  
  always @(posedge clock)
      begin
        if (uart_tick_16x) 
          begin
            if (~clock_lock) 
              begin
                clock_lock <= ~RxD_bit;
              end
            else 
              begin
                clock_lock <= ((state == IDLE) && (RxD_bit == 1'b1)) ? 1'b0 : clock_lock;
              end
            bit_spacing <= clock_lock ? (bit_spacing+1'b1) : 4'b1110;
          end
        else 
          begin
            clock_lock <= clock_lock;
            bit_spacing <= bit_spacing;
          end
      end
  wire  next_bit = bit_spacing == 4'b1111;

  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            state <= IDLE;
          end
        else if (uart_tick_16x) 
          begin
            case (state)

              IDLE: state <= (next_bit & (RxD_bit == 1'b0)) ? BIT_0 : IDLE;

              BIT_0: state <= next_bit ? BIT_1 : BIT_0;

              BIT_1: state <= next_bit ? BIT_2 : BIT_1;

              BIT_2: state <= next_bit ? BIT_3 : BIT_2;

              BIT_3: state <= next_bit ? BIT_4 : BIT_3;

              BIT_4: state <= next_bit ? BIT_5 : BIT_4;

              BIT_5: state <= next_bit ? BIT_6 : BIT_5;

              BIT_6: state <= next_bit ? BIT_7 : BIT_6;

              BIT_7: state <= next_bit ? STOP : BIT_7;

              STOP: state <= next_bit ? IDLE : STOP;

              default: state <= 4'bxxxx;

            endcase

          end
        else state <= state;
      end
  wire 
       capture = (uart_tick_16x & (next_bit & (state != STOP))) & (state != IDLE);

  
  always @(posedge clock)
      begin
        RxD_data <= capture ? {RxD_bit,RxD_data[7:1]} : RxD_data[7:0];
      end
  assign data_ready = (uart_tick_16x & (state == STOP)) & next_bit;
endmodule

