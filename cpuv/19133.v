module shift(normalized, selectedexp, shiftprod, shiftexp, shiftloss);
  input [`PRODWIDTH-1:0] normalized; 
  input [`WEXPSUM-1:0] selectedexp; 
  output [`SHIFTWIDTH-1:0] shiftprod; 
  output [`WEXPSUM-1:0] shiftexp; 
  output shiftloss; 
  wire [`WEXPSUM-1:0] roundedexp; 
  wire [`WEXPSUM-1:0] shiftamt; 
  wire [`WSHIFTAMT-1:0] actualshiftamt; 
  wire tozero; 
  wire doshift; 
  wire [`SHIFTWIDTH-1:0] preshift; 
  reg [`SHIFTWIDTH-1:0] postshift; 
  assign preshift = {normalized, `PRESHIFTZEROS};
  assign shiftamt = -selectedexp;
  assign doshift = ~shiftamt[`WEXPSUM-1];
  assign tozero = doshift & (shiftamt > `MAXSHIFT);
  assign actualshiftamt = tozero ? `MAXSHIFT : shiftamt[`WSHIFTAMT-1:0];
  always @ (actualshiftamt or preshift) begin
    case (actualshiftamt)
      5'b00001: postshift = preshift >> 5'b00001;
      5'b11111: postshift = preshift >> 5'b11111;
      default: postshift = preshift; 
    endcase
  end
  assign shiftprod = doshift ? postshift : preshift;
  assign shiftloss = tozero | (doshift & |postshift[`SHIFTWIDTH-`PRODWIDTH-1:0]);
  assign shiftexp = doshift ? 0 : selectedexp;
endmodule