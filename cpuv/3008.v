module simple_test_3a
  (
   input logic [8*16-1:0] wide_input_bus, 
   input logic [3:0]  selector,           
   output logic [7:0] selected_out        
  );
   always_comb
     selected_out = {
                     wide_input_bus[selector*8+7], 
                     wide_input_bus[selector*8+6],
                     wide_input_bus[selector*8+5],
                     wide_input_bus[selector*8+4],
                     wide_input_bus[selector*8+3],
                     wide_input_bus[selector*8+2],
                     wide_input_bus[selector*8+1],
                     wide_input_bus[selector*8]   
                    };
endmodule