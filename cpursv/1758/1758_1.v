
module my_module();

  reg  [15:0] ff_icap_din_reversed;
  reg  ff_icap_ce;
  reg  ff_icap_wr;
  wire [15:0] icap_din;
  wire icap_ce;
  wire icap_wr;

  
  always @(posedge clk)
      begin
        ff_icap_din_reversed[0] <= icap_din[7];
        ff_icap_din_reversed[1] <= icap_din[6];
        ff_icap_din_reversed[2] <= icap_din[5];
        ff_icap_din_reversed[3] <= icap_din[4];
        ff_icap_din_reversed[4] <= icap_din[3];
        ff_icap_din_reversed[5] <= icap_din[2];
        ff_icap_din_reversed[6] <= icap_din[1];
        ff_icap_din_reversed[7] <= icap_din[0];
        ff_icap_din_reversed[8] <= icap_din[15];
        ff_icap_din_reversed[9] <= icap_din[14];
        ff_icap_din_reversed[10] <= icap_din[13];
        ff_icap_din_reversed[11] <= icap_din[12];
        ff_icap_din_reversed[12] <= icap_din[11];
        ff_icap_din_reversed[13] <= icap_din[10];
        ff_icap_din_reversed[14] <= icap_din[9];
        ff_icap_din_reversed[15] <= icap_din[8];
        ff_icap_ce <= icap_ce;
        ff_icap_wr <= icap_wr;
      end
endmodule

