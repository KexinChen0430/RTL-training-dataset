module b2d_ssd (
  input [3:0] X,   
  output reg [0:6] SSD 
);
  always begin
    case(X)
      0: SSD = 7'b0000001; 
      1: SSD = 7'b1001111; 
      2: SSD = 7'b0010010; 
      3: SSD = 7'b0000110; 
      4: SSD = 7'b1001100; 
      5: SSD = 7'b0100100; 
      6: SSD = 7'b0100000; 
      7: SSD = 7'b0001111; 
      8: SSD = 7'b0000000; 
      9: SSD = 7'b0001100; 
      default: SSD = 7'b1111111; 
    endcase
  end
endmodule