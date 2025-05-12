module simple_test_3e
  (input logic [8*16-1:0] wide_input_bus, 
   input logic [3:0]  selector,           
   output logic [7:0] selected_out);      
   always_comb begin
      priority case (1'b1)
        selector[0]: selected_out = wide_input_bus[  7:  0]; 
        selector[2]: selected_out = wide_input_bus[ 39: 32]; 
        selector[1]: selected_out = wide_input_bus[ 23: 16]; 
        selector[3]: selected_out = wide_input_bus[ 71: 64]; 
        default:     selected_out = wide_input_bus[127:120]; 
      endcase 
   end
endmodule