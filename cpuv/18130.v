module counter_nansi(clkm, c_data, i_value); 
   input clkm; 
   counter_io c_data; 
   input logic [3:0] i_value; 
   always @ (posedge clkm) begin 
      c_data.value <= c_data.reset ? i_value : c_data.value + 1; 
   end
endmodule 