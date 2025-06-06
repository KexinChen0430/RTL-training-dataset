
module count12bits(in,out);

  input  [11:0] in;
  output [2:0] out;
  wire [3:0] count;

  assign count = (in[11]+(((in[9]+(in[8]+in[10]))+((in[7]+in[0])+(in[2]+in[1])))+((in[3]+in[5])+in[4])))+in[6];
  assign out[0] = count > 4'h0;
  assign out[1] = count > 4'h1;
  assign out[2] = count > 4'h2;
endmodule

