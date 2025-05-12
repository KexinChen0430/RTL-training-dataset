
module c(clock,c_in,d_in,out1);

  input  clock;
  input  c_in;
  input  d_in;
  output out1;
  reg  out1;
  reg  temp;

  
  always @(posedge clock)
      begin
        temp <= d_in & c_in;
        out1 <= ((~d_in | d_in) & (temp & (~d_in | d_in))) ^ d_in;
      end
endmodule

