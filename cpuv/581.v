module demux
    #(
      parameter C_OUTPUTS = 12, 
      parameter C_WIDTH = 1     
      )
    (
     input [C_WIDTH-1:0]            WR_DATA, 
     input [clog2s(C_OUTPUTS)-1:0]  WR_SEL,  
     output [C_OUTPUTS*C_WIDTH-1:0] RD_DATA  
     );
`include "functions.vh"
genvar                          i;
reg [C_OUTPUTS*C_WIDTH-1:0]     _rOut;
assign RD_DATA = _rOut;
always @(*) begin
    _rOut = 0; 
    _rOut[C_WIDTH*WR_SEL +: C_WIDTH] = WR_DATA;
end
endmodule