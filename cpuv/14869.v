module OV7670Init (index_i, data_o);
   input       [5:0] index_i;    
   output reg  [16:0] data_o;    
   always @* begin
      (* parallel_case *) case(index_i)
         6'd0 : data_o = {16'h1280, 1'b1};   
         6'd1 : data_o = {16'hf0f0, 1'b1};   
         6'd2 : data_o = {16'h1204, 1'b1};   
         6'd3 : data_o = {16'h1100, 1'b1};   
         6'd4 : data_o = {16'h0C00, 1'b1};   
         6'd5 : data_o = {16'h3E00, 1'b1};   
         6'd6 : data_o = {16'h8C00, 1'b1};   
         6'd7 : data_o = {16'h0400, 1'b1};   
         6'd8 : data_o = {16'h40d0, 1'b1};   
         6'd9 : data_o = {16'h3a04, 1'b1};   
         6'd10: data_o = {16'h1418, 1'b1};   
         6'd11: data_o = {16'h4fb3, 1'b1};   
         6'd12: data_o = {16'h50b3, 1'b1};   
         6'd13: data_o = {16'h5100, 1'b1};   
         6'd14: data_o = {16'h523d, 1'b1};   
         6'd15: data_o = {16'h53a7, 1'b1};   
         6'd16: data_o = {16'h54e4, 1'b1};   
         6'd17: data_o = {16'h589e, 1'b1};   
         6'd18: data_o = {16'h3dc0, 1'b1};   
         6'd19: data_o = {16'h1100, 1'b1};   
         6'd20: data_o = {16'h1714, 1'b1};   
         6'd21: data_o = {16'h1802, 1'b1};   
         6'd22: data_o = {16'h3280, 1'b1};   
         6'd23: data_o = {16'h1903, 1'b1};   
         6'd24: data_o = {16'h1A7b, 1'b1};   
         6'd25: data_o = {16'h030a, 1'b1};   
         6'd26: data_o = {16'h0f41, 1'b1};   
         6'd27: data_o = {16'h1e03, 1'b1};   
         6'd28: data_o = {16'h330b, 1'b1};   
         6'd29: data_o = {16'h3c78, 1'b1};   
         6'd30: data_o = {16'h6900, 1'b1};   
         6'd31: data_o = {16'h6b1a, 1'b1};   
         6'd32: data_o = {16'h7400, 1'b1};   
         6'd33: data_o = {16'hb084, 1'b1};   
         6'd34: data_o = {16'hb10c, 1'b1};   
         6'd35: data_o = {16'hb20e, 1'b1};   
         6'd36: data_o = {16'hb380, 1'b1};   
         default: data_o = {16'hffff, 1'b1}; 
      endcase
   end
endmodule