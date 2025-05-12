
module debnce(input  wire sync,
              input  wire clk,
              output reg event_on,
              output reg event_off);

  reg  [15:0] ctr;
  reg  dly;
  wire sat;

  assign sat = ctr == 16'hffff;
  
  always @(posedge clk)
      begin : saturating_counter
        case ({sync,sat})

          0: ctr <= 0;

          1: ctr <= 0;

          2: ctr <= 1+ctr;

        endcase

        dly <= sat;
        event_on <= !dly && sat;
        event_off <= dly && !sat;
      end
endmodule

