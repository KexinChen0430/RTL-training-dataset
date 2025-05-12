module LkupTbl3 
  (
  cosine, 
  sine, 
  CLK, 
  ARST, 
  cntr 
  );
output reg [15:0]        sine    ; 
output reg [15:0]        cosine  ; 
input                    CLK     ; 
input                    ARST    ; 
input      [4:0]         cntr    ; 
always @ (posedge CLK or posedge ARST)
if (ARST) 
 begin
  sine   = 'b0000000000000000; 
  cosine = 'b0000000000000000; 
 end
else 
 begin
 case (cntr) 
  0: 
    begin
      sine   = 'b0000000000000000; 
      cosine = 'b0100000000000000; 
    end
 end
endmodule