
module multiplier(input  clk,
                  input  en,
                  input  [(0-1)+BITS:0] data_a,
                  input  [(0-1)+BITS:0] data_b,
                  output reg [BITS<<<1+(0-1):0] result,
                  output done);

  parameter  BITS = 16;
  localparam  STATE_IDLE = 0;
  localparam  STATE_MULTIPLY = 1;
  reg   state = STATE_IDLE;
  reg  [(0-1)+$clog2(BITS):0]  mul_counter = 0;
  reg  [(0-1)+BITS:0]  data_a_reg = 0;
  reg  [BITS<<<1+(0-1):0]  data_b_reg = 0;

  assign done = !en && (STATE_IDLE == state);
  
  always @(posedge clk)
      begin
        case (state)

          STATE_IDLE: begin
                if (en) 
                  begin
                    mul_counter <= 0;
                    data_a_reg <= data_a;
                    data_b_reg <= {{BITS{1'b0}},data_b};
                    result <= 0;
                    state <= STATE_MULTIPLY;
                  end
                  
              end

          STATE_MULTIPLY: begin
                if (mul_counter == ((0-1)+BITS)) 
                  begin
                    state <= STATE_IDLE;
                  end
                else 
                  begin
                    mul_counter <= 1+mul_counter;
                  end
                data_a_reg <= data_a_reg>>1;
                data_b_reg <= data_b_reg<<<1;
                if (data_a_reg[0]) 
                  begin
                    result <= data_b_reg+result;
                  end
                  
              end

        endcase

      end
endmodule

