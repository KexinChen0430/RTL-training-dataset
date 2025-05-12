
module bin2sevenSeg(input  wire clk,
                    input  wire [13:0] d_in,
                    output reg [15:0] fullOutput,
                    output reg [3:0] segA,
                    output reg [3:0] segB,
                    output reg [3:0] segC,
                    output reg [3:0] segD,
                    output reg [13:0] d_out);

  reg  [13:0] d_inCopy;
  reg  [15:0] fullOutputCopy;
  reg  copyDone;

  
  initial  
  begin
    fullOutput = 0;
    segA = 0;
    segB = 0;
    segC = 0;
    segD = 0;
    d_inCopy = 0;
  end
  integer i;

  
  always @(d_in)
      begin
        for (i = 0; i < 14; i = i+1)
            begin
              d_inCopy[i] = d_in[i];
            end
        d_out = d_inCopy;
        copyDone = 1'b1;
      end
  
  always @(posedge copyDone)
      begin
        for (i = 0; i < 14; i = i+1)
            begin

            end
        fullOutput = fullOutputCopy;
        copyDone = 1'b0;
      end
endmodule

