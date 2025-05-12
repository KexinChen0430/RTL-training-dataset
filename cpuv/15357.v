module intf_sink
(
   output [0:N-1] a_out,
   a_if.sink i_intf_sink[0:N-1]
);
generate
   for (genvar i=0; i < N;i++) begin
      assign a_out[i] = i_intf_sink[i].long_name;
   end
endgenerate
endmodule