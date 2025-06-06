
module lf(clk,reset_n,ast_sink_data,ast_sink_valid,ast_source_ready,
          ast_sink_error,ast_source_data,ast_sink_ready,
          ast_source_valid,ast_source_error);

  input  clk;
  input  reset_n;
  input  [14:0] ast_sink_data;
  input  ast_sink_valid;
  input  ast_source_ready;
  input  [1:0] ast_sink_error;
  output [30:0] ast_source_data;
  output ast_sink_ready;
  output ast_source_valid;
  output [1:0] ast_source_error;


endmodule

