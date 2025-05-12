module translate_8042 (
    input      [6:0] at_code, 
    output reg [6:0] xt_code  
);
  always @(at_code)
    case (at_code)
      7'h00: xt_code <= 7'h7f; 
      7'h01: xt_code <= 7'h43; 
      7'h02: xt_code <= 7'h41; 
      7'h7e: xt_code <= 7'h46; 
      7'h7f: xt_code <= 7'h54; 
    endcase
endmodule