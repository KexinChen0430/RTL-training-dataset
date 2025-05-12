module simple_test_3f
  (
    input logic [8*16-1:0] wide_input_bus, 
    input logic [3:0]      selector,       
    output logic [7:0]     selected_out    
  );
  always_comb begin
    priority casez (selector[3:0])
      4'b0?10: selected_out = wide_input_bus[ 15:  8]; 
      4'b0??0: selected_out = wide_input_bus[ 23: 16]; 
      4'b0100: selected_out = wide_input_bus[ 31: 24]; 
      default: selected_out = wide_input_bus[127:120]; 
    endcase 
  end 
endmodule 