
module f8_inc(clock,counter);

  input  clock;
  output reg [3:0] counter;

  
  always @(posedge clock)  counter <= 1+counter;
endmodule

