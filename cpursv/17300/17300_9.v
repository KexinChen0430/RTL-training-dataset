
module decoder4to16(in,out);

  output reg [15:1] out;
  input  [3:0] in;
  reg  [3:0] in_bar;

  
  always @(*)
      begin
        in_bar = ~in;
        out[1] = ((in[0] & in_bar[2]) & in_bar[1]) & in_bar[3];
        out[2] = (in_bar[0] & in_bar[3]) & (in[1] & in_bar[2]);
        out[3] = (in_bar[3] & (in[1] & in[0])) & in_bar[2];
        out[4] = (in_bar[1] & (in[2] & in_bar[3])) & in_bar[0];
        out[5] = in[0] & (in_bar[1] & (in[2] & in_bar[3]));
        out[6] = (in[2] & (in[1] & in_bar[3])) & in_bar[0];
        out[7] = (in[1] & in[0]) & (in[2] & in_bar[3]);
        out[8] = in_bar[1] & ((in_bar[0] & in_bar[2]) & in[3]);
        out[9] = (in_bar[1] & in_bar[2]) & (in[3] & in[0]);
        out[10] = (in_bar[0] & in[3]) & (in[1] & in_bar[2]);
        out[11] = (in[3] & in[0]) & (in[1] & in_bar[2]);
        out[12] = (in_bar[1] & in[2]) & (in_bar[0] & in[3]);
        out[13] = (in[0] & in_bar[1]) & (in[3] & in[2]);
        out[14] = in[1] & ((in[3] & in[2]) & in_bar[0]);
        out[15] = (in[2] & in[1]) & (in[3] & in[0]);
      end
endmodule

