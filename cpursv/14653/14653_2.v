
module test(I1,I2,I3,I4,enter,win,lose,reset,equal,bigger,smaller,nums,
            CLK,outs,numa);

  input  CLK;
  wire good;
  output reg outs;
  reg  [0:22] out;

  
  always @(posedge good or posedge reset)
      begin
        if (reset) outs = 0;
        else outs = ~outs;
      end
  
  always @(posedge CLK or posedge reset)
      begin
        if (reset) out = 0;
        else out = 1+out;
      end
  assign good = out == 23'd100000;
  input  I1,I2,I3,I4,enter,reset;

  reg  [0:6] a1,a2,a3,a4,suc,b1,b2,b3,b4;

  output reg [0:3] numa;

  reg  [0:3] numb;

  output reg win,lose;

  output reg equal,bigger,smaller;

  reg  runa,runb;

  reg  [0:3] turn;

  output reg [0:3] nums;

  reg  [0:4] ins;

  
  initial  
  begin
    ins = 0;
    nums = 0;
    win = 0;
    suc = 0;
    runa = 1;
    runb = 0;
    lose = 0;
    equal = 0;
    bigger = 0;
    smaller = 0;
    a1 = 0;
    a2 = 0;
    a3 = 0;
    a4 = 0;
    b1 = 0;
    b2 = 0;
    b3 = 0;
    b4 = 0;
    numa = 0;
    numb = 0;
    turn = 0;
  end
  
  always @(posedge good or posedge reset)
      begin
        if (reset) 
          begin
            win = 0;
            suc = 0;
            runa = 1;
            runb = 0;
            lose = 0;
            equal = 0;
            bigger = 0;
            smaller = 0;
            nums = 0;
            a1 = 0;
            a2 = 0;
            a3 = 0;
            a4 = 0;
            b1 = 0;
            b2 = 0;
            b3 = 0;
            b4 = 0;
            numa = 0;
            numb = 0;
            turn = 0;
            ins = 0;
          end
        else 
          begin

          end
      end
endmodule

