
module pipeline_registers(input  clk,
                          input  reset_n,
                          input  [(0-1)+BIT_WIDTH:0] pipe_in,
                          output reg [(0-1)+BIT_WIDTH:0] pipe_out);

  parameter  BIT_WIDTH = 10, NUMBER_OF_STAGES = 5;

  
  generate
      genvar i;
      if (NUMBER_OF_STAGES == 0) 
        begin
          
          always @*           pipe_out = pipe_in;
        end
      else if (NUMBER_OF_STAGES == 1) 
        begin
          
          always @(posedge clk or negedge reset_n)
              pipe_out <= !reset_n ? 0 : pipe_in;
        end
      else 
        begin
          reg  [(0-1)+(BIT_WIDTH*(NUMBER_OF_STAGES+(0-1))):0] pipe_gen;

          
          always @(posedge clk or negedge reset_n)
              begin
                if (!reset_n) 
                  begin
                    pipe_gen[(0-1)+BIT_WIDTH:0] <= 0;
                    pipe_out <= 0;
                  end
                else 
                  begin
                    pipe_gen[(0-1)+BIT_WIDTH:0] <= pipe_in;
                    pipe_out <= pipe_gen[(0-1)+(BIT_WIDTH*(NUMBER_OF_STAGES+(0-1))):(NUMBER_OF_STAGES-(1+1))*BIT_WIDTH];
                  end
              end
          for (i = 1; i < (NUMBER_OF_STAGES+(0-1)); i = 1+i)
              begin : pipeline
                
                always @(posedge clk or negedge reset_n)
                    pipe_gen[((1+i)*BIT_WIDTH)+(0-1):i*BIT_WIDTH] <= !reset_n ? 0 : pipe_gen[(i*BIT_WIDTH)-1:BIT_WIDTH*((0-1)+i)];
              end
        end
  endgenerate

endmodule

