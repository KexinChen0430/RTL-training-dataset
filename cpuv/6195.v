module
finish  <= 0;
_clear  <= 1;
_enable <= 0;
end else begin
_error[0] = 1;
end
always @ (posedge clk) begin
if (_start && ~_running && ~_waiting) begin
_running <= 1;
_i = bitLength - 2;
if (_i == 0) begin
_running <= 0;
_waiting <= 1;
end
end else if (_start && _running & ~_waiting) begin
_i = _i - 1;
if (_i == 1) begin
_running <= 0;
_waiting <= 1;
end
end else if (_start && _waiting) begin
end else begin
_running = 0;
_waiting = 0;
end
end
assign state = {_start, _running, _waiting};
always @ (posedge clk) begin
_sync_enable <= _enable;
end
always @ (posedge clk) begin
_edge_useModule[1] <= _edge_useModule[0];
_edge_useModule[0] <= useModule;
end
always @ (posedge clk) begin
_sync_useModule <= useModule;
end
endmodule