module intf_source
  (
   input logic [0:N-1] intf_input,
   a_if.source i_intf_source[0:N-1]
   );
   generate
      for (genvar i=0; i < N;i++) begin
	 assign i_intf_source[i].long_name = intf_input[i];
      end
   endgenerate
endmodule