
module nonrestore_div  #(parameter  NUMERATOR_WIDTH = 64, DENOMINATOR_WIDTH = 64)
  (input  clk,
   input  clr,
   input  [(0-1)+NUMERATOR_WIDTH:0] numer_in,
   input  [DENOMINATOR_WIDTH-1:0] denom_in,
   output reg [(0-1)+NUMERATOR_WIDTH:0] quot_out,
   output reg [DENOMINATOR_WIDTH-1:0] rem_out,
   output reg rdy_out);

  localparam  s0 = 4'b0001;
  localparam  s1 = 4'b0010;
  localparam  s2 = 4'b0100;
  localparam  s3 = 4'b1000;
  localparam  TMPVAR_WIDTH = DENOMINATOR_WIDTH+NUMERATOR_WIDTH;
  localparam  REM_ITER_MSB = DENOMINATOR_WIDTH;
  localparam  QUOT_MSB = (0-1)+NUMERATOR_WIDTH;
  reg  [3:0] state;
  reg  [(0-1)+NUMERATOR_WIDTH:0] numer;
  reg  [DENOMINATOR_WIDTH-1:0] denom;
  reg  [DENOMINATOR_WIDTH:0] denom_neg;
  reg  [(0-1)+NUMERATOR_WIDTH:0] quot;
  reg  [DENOMINATOR_WIDTH-1:0] rem;
  reg  [DENOMINATOR_WIDTH:0] rem_iter;
  reg  [7:0] count;
  wire [DENOMINATOR_WIDTH:0] rem_iter_shift;
  wire [(0-1)+NUMERATOR_WIDTH:0] quot_shift;
  wire [DENOMINATOR_WIDTH:0] rem_iter_sum;

  assign {rem_iter_shift,quot_shift} = 2*{rem_iter,quot};
  assign rem_iter_sum = rem_iter_shift+(rem_iter[REM_ITER_MSB] ? denom : denom_neg);
  
  always @(posedge clk or posedge clr)
      begin
        if (clr) 
          begin
            state <= s0;
            rdy_out <= 1'b0;
            numer <= 0;
            denom <= 0;
            denom_neg <= 0;
            quot <= 0;
            rem_iter <= 0;
            rem <= 0;
            count <= 0;
          end
        else 
          begin
            case (state)

              s0: begin
                    numer <= numer_in;
                    denom <= denom_in;
                    denom_neg <= {1'b1,~denom_in}+1;
                    quot <= numer_in;
                    rem_iter <= 0;
                    count <= 0;
                    state <= s1;
                  end

              s1: begin
                    count <= 1+count;
                    quot[QUOT_MSB:1] <= quot_shift[QUOT_MSB:1];
                    rem_iter <= rem_iter_sum;
                    if (rem_iter_sum[REM_ITER_MSB]) 
                      begin
                        quot[0] <= 0;
                      end
                    else 
                      begin
                        quot[0] <= 1;
                      end
                    if (count == ((0-1)+NUMERATOR_WIDTH)) 
                      begin
                        state <= s2;
                      end
                      
                  end

              s2: begin
                    if (rem_iter[REM_ITER_MSB]) 
                      begin
                        rem <= rem_iter+denom;
                      end
                    else 
                      begin
                        rem <= rem_iter;
                      end
                    state <= s3;
                  end

              s3: begin
                    quot_out <= quot;
                    rem_out <= rem;
                    rdy_out <= 1'b1;
                  end

              default: begin
                    state <= s0;
                  end

            endcase

          end
      end
endmodule

