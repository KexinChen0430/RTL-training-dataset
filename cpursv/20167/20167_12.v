
module f14_TECH_XOR2(input  [1:0] in,
                     output out);

  assign out = ((((~in[1] | in[1]) & in[0]) & in[1]) ^ in[1]) ^ (((in[0] ^ (in[1] & in[0])) | in[1]) & (((in[0] ^ (in[1] & in[0])) | in[1]) & (in[0] ^ (in[1] & in[0]))));
endmodule

