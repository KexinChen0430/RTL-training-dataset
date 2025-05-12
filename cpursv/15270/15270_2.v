
module watchdog(input  wire clk,
                input  wire en,
                input  wire I,
                output reg O);

  reg  [7:0] counter;
  reg  II;

  
  always @(posedge clk)
      begin
        II <= I;
        if ((II != O) && counter[7]) 
          begin
            O <= II;
            counter <= 28;
          end
        else if (en) counter <= 1+counter;
          
      end
endmodule

