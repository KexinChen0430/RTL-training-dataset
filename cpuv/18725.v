module sm ();
`include "autoasciienum_param.v"
   reg [3:0]		chip_r;
   reg [31:0]		chip_r__ascii;		
   always @(chip_r) begin
      case ({chip_r})
	EP_C14ChipNum_RNP:  chip_r__ascii = "rnp ";
	EP_C14ChipNum_SPP:  chip_r__ascii = "spp ";
	EP_C14ChipNum_SRP:  chip_r__ascii = "srp ";
	EP_C14ChipNum_SMM2: chip_r__ascii = "smm2";
	EP_C14ChipNum_SMM:  chip_r__ascii = "smm ";
	EP_C14ChipNum_TTE:  chip_r__ascii = "tte ";
	EP_C14ChipNum_DLE:  chip_r__ascii = "dle ";
	EP_C14ChipNum_OASP: chip_r__ascii = "oasp";
	default:            chip_r__ascii = "%Err";
      endcase
   end
endmodule