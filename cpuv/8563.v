module since D0 bit is read first
      icap_dout[0]  <= icap_dout_reversed[7];
      icap_dout[1]  <= icap_dout_reversed[6];
      icap_dout[2]  <= icap_dout_reversed[5];
      icap_dout[3]  <= icap_dout_reversed[4];
      icap_dout[4]  <= icap_dout_reversed[3];
      icap_dout[5]  <= icap_dout_reversed[2];
      icap_dout[6]  <= icap_dout_reversed[1];
      icap_dout[7]  <= icap_dout_reversed[0];
      icap_dout[8]  <= icap_dout_reversed[15];
      icap_dout[9]  <= icap_dout_reversed[14];
      icap_dout[10] <= icap_dout_reversed[13];
      icap_dout[11] <= icap_dout_reversed[12];
      icap_dout[12] <= icap_dout_reversed[11];
      icap_dout[13] <= icap_dout_reversed[10];
      icap_dout[14] <= icap_dout_reversed[9];
      icap_dout[15] <= icap_dout_reversed[8];
   end
endmodule