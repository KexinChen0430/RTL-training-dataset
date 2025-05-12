module Mux32(
    select,      
    data_i00,    
    data_i01,    
    data_i31,    
    data_o       
);
   parameter Size = 8;
   input wire [('d5) - ('b1):0] select;
   input wire [(Size) - ('b1):0] data_i00;
   input wire [(Size) - ('b1):0] data_i31;
   output reg [(Size) - ('b1):0] data_o;
   always @ (select or
             data_i00 or data_i01 or data_i02 or data_i03 or data_i04 or data_i05 or data_i06 or data_i07 or
             data_i08 or data_i09 or data_i10 or data_i11 or data_i12 or data_i13 or data_i14 or data_i15 or
             data_i16 or data_i17 or data_i18 or data_i19 or data_i20 or data_i21 or data_i22 or data_i23 or
             data_i24 or data_i25 or data_i26 or data_i27 or data_i28 or data_i29 or data_i30 or data_i31) begin
      case (select)
        'b00000: data_o = data_i00; 
        'b00001: data_o = data_i01; 
        'b11111: data_o = data_i31; 
      endcase
   end
endmodule