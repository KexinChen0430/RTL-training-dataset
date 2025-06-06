
module clock_divider  #(parameter  DIVISOR = 40000000)
  (input  wire CLK,
   input  wire RESET,
   output reg CE,
   output reg CLOCK);

  integer counter_ce;

  
  initial    counter_ce = 0;
  integer counter_clk;

  
  initial    counter_clk = 0;
  
  initial    CLOCK = 1'b0;
  
  initial    CE = 1'b0;
  
  always @(posedge CLK or posedge RESET)
      begin
        if (RESET == 1'b1) 
          begin
            CE <= 1'b0;
          end
        else 
          begin
            if (counter_ce == 0) 
              begin
                CE <= 1'b1;
              end
            else 
              begin
                CE <= 1'b0;
              end
          end
      end
  
  always @(posedge CLK or posedge RESET)
      begin
        if (RESET == 1'b1) 
          begin
            counter_ce <= 0;
          end
        else 
          begin
            if (counter_ce == (DIVISOR-1)) counter_ce <= 0;
            else counter_ce <= 1+counter_ce;
          end
      end
  
  always @(posedge CLK or posedge RESET)
      begin
        if (RESET == 1'b1) 
          begin
            CLOCK <= 1'b0;
          end
        else 
          begin
            if (counter_clk == 0) 
              begin
                CLOCK <= ~CLOCK;
              end
            else 
              begin
                CLOCK <= CLOCK;
              end
          end
      end
  
  always @(posedge CLK or posedge RESET)
      begin
        if (RESET == 1'b1) 
          begin
            counter_clk <= 0;
          end
        else 
          begin
            if (counter_clk == (DIVISOR>>1+(-1))) counter_clk <= 0;
            else counter_clk <= counter_clk+1;
          end
      end
endmodule

