module simple_test_3c
  (
   input logic [8*16-1:0] wide_input_bus,
   input logic [3:0]  selector,
   output logic [7:0] selected_out);
   always_comb begin
      unique case (selector)
        4'h0: selected_out = wide_input_bus[  7:  0];
        4'h1: selected_out = wide_input_bus[ 15:  8];
        4'h2: selected_out = wide_input_bus[ 23: 16];
        4'h3: selected_out = wide_input_bus[ 31: 24];
        4'h4: selected_out = wide_input_bus[ 39: 32];
        4'h5: selected_out = wide_input_bus[ 47: 40];
        4'h6: selected_out = wide_input_bus[ 55: 48];
        4'h7: selected_out = wide_input_bus[ 63: 56];
        4'h8: selected_out = wide_input_bus[ 71: 64];
        4'h9: selected_out = wide_input_bus[ 79: 72];
        4'ha: selected_out = wide_input_bus[ 87: 80];
        4'hb: selected_out = wide_input_bus[ 95: 88];
        4'hc: selected_out = wide_input_bus[103: 96];
        4'hd: selected_out = wide_input_bus[111:104];
        4'he: selected_out = wide_input_bus[119:112];
        4'hf: selected_out = wide_input_bus[127:120];
      endcase 
   end
endmodule