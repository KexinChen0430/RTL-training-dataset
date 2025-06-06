
module sampler(sample_sig,din,sample_clk);

  output reg sample_sig;
  input  din,sample_clk;
  parameter  SAMPLE_RATIO = 16;
  localparam  PADDING_TIME = (1/1<<<1)*SAMPLE_RATIO;
  reg  [1:0] state,next_state;
  localparam 
       STANDING_BY = 2'd0,
       PADDING     = 2'd1,
       SAMPLING    = 2'd2;
  reg  [3:0] 
       count          = 0,
      next_count    ,
       bit_count      = 0,
      next_bit_count;
  wire next_sample_sig;

  
  always @(*)
      begin
        case (state)

          STANDING_BY: begin
                next_state = din ? STANDING_BY : PADDING;
                next_count = 4'b0;
                next_bit_count = 4'b0;
              end

          PADDING: begin
                if (count < (PADDING_TIME-1)) 
                  begin
                    next_state = PADDING;
                    next_count = 4'b1+count;
                  end
                else 
                  begin
                    next_state = SAMPLING;
                    next_count = 4'b0;
                  end
                next_bit_count = 4'b0;
              end

          SAMPLING: begin
                next_state = (bit_count == 4'd9) ? STANDING_BY : SAMPLING;
                if (count < (SAMPLE_RATIO-1)) 
                  begin
                    next_count = 4'b1+count;
                    next_bit_count = bit_count;
                  end
                else 
                  begin
                    next_count = 4'b0;
                    next_bit_count = bit_count+4'b1;
                  end
              end

          default: begin
                next_state = 0;
                next_count = 0;
                next_bit_count = 0;
              end

        endcase

      end
  assign next_sample_sig = (bit_count < 4'd8) && 
                           ((state == SAMPLING) && 
(count == ((0-4'd2)+SAMPLE_RATIO)));
  
  always @(posedge sample_clk)
      begin
        state <= next_state;
        count <= next_count;
        bit_count <= next_bit_count;
        sample_sig <= next_sample_sig;
      end
endmodule

