
module f10_MyCounter(clock,preset,updown,presetdata,counter);

  input  clock,preset,updown;
  input  [1:0] presetdata;
  output reg [1:0] counter;

  
  always @(posedge clock)
      if (preset) counter <= presetdata;
      else if (updown) counter <= 1+counter;
      else counter <= (-1)+counter;
endmodule

