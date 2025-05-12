module intf_source 
  (
   input logic [N-1:0] intf_input, 
   a_if.source i_intf_source[N-1:0] 
   );
   generate 
      for (genvar i=0; i < N;i++) begin 
	 assign i_intf_source[i].long_name = intf_input[i]; 
      end
   endgenerate 
endmodule 