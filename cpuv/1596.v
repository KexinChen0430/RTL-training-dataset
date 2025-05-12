module ledput
);
assign io_i = sw[0];
assign io_t = sw[1];
assign jc3  = sw[2];
assign led[0] = io_o;
assign led[1] = jc1;
assign led[15:2] = {sw[15:3], 1'd0};
endmodule