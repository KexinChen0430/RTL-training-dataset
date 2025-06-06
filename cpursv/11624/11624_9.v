
module minimig_sram_bridge(input  clk,
                           input  c1,
                           input  c3,
                           input  [7:0] bank,
                           input  [18:1] address_in,
                           input  [15:0] data_in,
                           output [15:0] data_out,
                           input  rd,
                           input  hwr,
                           input  lwr,
                           output _bhe,
                           output _ble,
                           output _we,
                           output _oe,
                           output [21:1] address,
                           output [15:0] data,
                           input  [15:0] ramdata_in);

  wire enable;
  reg  doe;

  assign enable = (bank[7:0] == 8'b00000000) ? 1'b0 : 1'b1;
  assign _we = !enable | !hwr && !lwr;
  assign _oe = !enable | !rd;
  assign _bhe = !hwr | !enable;
  assign _ble = !lwr | !enable;
  
  always @(posedge clk)
      if (!c1 && !c3) doe <= 1'b0;
      else if (enable && c1 && (!rd && !c3)) doe <= 1'b1;
        
  assign address = {(bank[5] | (bank[6] | bank[4])) | bank[7],(bank[6] | bank[7]) | (bank[2] | bank[3]),(bank[5] | (bank[3] | bank[1])) | bank[7],address_in[18:1]};
  assign data_out[15:0] = (rd && enable) ? ramdata_in[15:0] : 16'b0000000000000000;
  assign data[15:0] = data_in[15:0];
endmodule

