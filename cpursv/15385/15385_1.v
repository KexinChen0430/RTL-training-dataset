
module v_fltr_316(tm3_clk_v0,vidin_new_data,vidin_in,vidin_out);

  input  tm3_clk_v0;
  input  vidin_new_data;
  input  [7:0] vidin_in;
  output [7:0] vidin_out;
  wire [7:0] vidin_out;
  wire [7:0] buff_out0;
  wire [7:0] buff_out1;
  wire [7:0] buff_out2;
  wire [7:0] buff_out3;

  assign buff_out0 = vidin_in;
  my_fifo_316 fifo0(tm3_clk_v0,buff_out0,buff_out1,vidin_new_data);
  my_fifo_316 fifo1(tm3_clk_v0,buff_out1,buff_out2,vidin_new_data);
  my_fifo_316 fifo2(tm3_clk_v0,buff_out2,buff_out3,vidin_new_data);
  my_fifo_316 more_inst(tm3_clk_v0,buff_out3,vidin_out,vidin_new_data);
endmodule

