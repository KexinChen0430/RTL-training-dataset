
module d(clock,c_in,d_in,out1);

  input  clock;
  input  c_in;
  input  d_in;
  output out1;
  reg  out1;
  reg  temp;

  
  always @(posedge clock)
      begin
        out1 <= temp+(0-d_in);
        temp <= c_in+(0-d_in);
      end
endmodule

