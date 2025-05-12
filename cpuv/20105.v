module test_comment_in_macro ( din_a, dout_a ); 
input [`SIZE-1:0] din_a; 
output [`SIZE-1:0] dout_a; 
assign dout_a = din_a | `SIZE'ha; 
endmodule 