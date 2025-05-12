module intf_sink
  (
   output [N-1:0] a_out,          
   a_if.sink i_intf_sink[N-1:0]   
   );
   generate
      for (genvar i=0; i < N;i++) begin
	 assign a_out[i] = i_intf_sink[i].long_name;
      end
   endgenerate
endmodule