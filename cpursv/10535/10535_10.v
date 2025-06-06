
module async_receiver(clk,Baud8Tick,RxD,RxD_data_ready,RxD_data,RxD_endofpacket,
                      RxD_idle);

  input  clk;
  input  RxD;
  input  Baud8Tick;
  output [7:0] RxD_data;
  output RxD_data_ready;
  output RxD_endofpacket;
  output RxD_idle;
  reg  [1:0] RxD_sync_inv;

  
  always @(posedge clk)
      if (Baud8Tick) RxD_sync_inv <= {RxD_sync_inv[0],~RxD};
        
  reg  [1:0] RxD_cnt_inv;

  reg  RxD_bit_inv;

  
  always @(posedge clk)
      if (Baud8Tick) 
        begin
          if ((RxD_cnt_inv != 2'b11) && RxD_sync_inv[1]) RxD_cnt_inv <= RxD_cnt_inv+2'h1;
          else if ((RxD_cnt_inv != 2'b00) && ~RxD_sync_inv[1]) RxD_cnt_inv <= RxD_cnt_inv+(0-2'h1);
            
          if (RxD_cnt_inv == 2'b00) RxD_bit_inv <= 1'b0;
          else if (RxD_cnt_inv == 2'b11) RxD_bit_inv <= 1'b1;
            
        end
        
  reg  [3:0] state;

  reg  [3:0] bit_spacing;

  wire  next_bit = bit_spacing == 4'd10;

  
  always @(posedge clk)
      if (state == 0) bit_spacing <= 4'b0000;
      else if (Baud8Tick) 
        bit_spacing <= {4'b0001+bit_spacing[2:0]} | {bit_spacing[3],3'b000};
        
  
  always @(posedge clk)
      if (Baud8Tick) 
        case (state)

          4'b0000: if (RxD_bit_inv) state <= 4'b1000;
                

          4'b1000: if (next_bit) state <= 4'b1001;
                

          4'b1001: if (next_bit) state <= 4'b1010;
                

          4'b1010: if (next_bit) state <= 4'b1011;
                

          4'b1011: if (next_bit) state <= 4'b1100;
                

          4'b1100: if (next_bit) state <= 4'b1101;
                

          4'b1101: if (next_bit) state <= 4'b1110;
                

          4'b1110: if (next_bit) state <= 4'b1111;
                

          4'b1111: if (next_bit) state <= 4'b0001;
                

          4'b0001: if (next_bit) state <= 4'b0000;
                

          default: state <= 4'b0000;

        endcase

        
  reg  [7:0] RxD_data;

  
  always @(posedge clk)
      if (state[3] && next_bit && Baud8Tick) RxD_data <= {~RxD_bit_inv,RxD_data[7:1]};
        
  reg  RxD_data_ready,RxD_data_error;

  
  always @(posedge clk)
      begin
        RxD_data_ready <= (state == 4'b0001) && (~RxD_bit_inv && Baud8Tick) && 
                         next_bit;
        RxD_data_error <= next_bit && 
                         ((state == 4'b0001) && Baud8Tick && RxD_bit_inv);
      end
  reg  [4:0] gap_count;

  
  always @(posedge clk)
      if (state != 0) gap_count <= 5'h00;
      else if (Baud8Tick & ~gap_count[4]) gap_count <= gap_count+5'h01;
        
  assign RxD_idle = gap_count[4];
  reg  RxD_endofpacket;

  
  always @(posedge clk)
      RxD_endofpacket <= Baud8Tick & (gap_count == 5'h0F);
endmodule

