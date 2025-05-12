module reg_256x32b_3r_1w
  (
   rd0_data, rd1_data, rd2_data, 
   clk, rd0_addr, rd1_addr, rd2_addr, wr0_addr, wr0_en, wr0_data 
   );
   input clk; 
   output [31:0] rd0_data; 
   output [31:0] rd1_data; 
   output [31:0] rd2_data; 
   input [7:0]   rd0_addr; 
   input [7:0]   rd1_addr; 
   input [7:0]   rd2_addr; 
   input [7:0]   wr0_addr; 
   input         wr0_en;   
   input [31:0]  wr0_data; 
   wire [8191:0] word_out; 
   wire [8191:0] word_in;  
   wire [255:0]  wr_en_word; 
   wire [255:0]  wr0_word_select; 
   wire [31:0]   rd0_data_i; 
   wire [31:0]   rd1_data_i; 
   wire [31:0]   rd2_data_i; 
   flop_32b word[255:0](.out(word_out), .in(word_in), .wr_en(wr_en_word), .clk(clk));
   mux_256x32b_to_1x32b mux_rd_port_0
     (.out(rd0_data_i),
      .in(word_out),
      .select(rd0_addr));
   mux_256x32b_to_1x32b mux_rd_port_1
     (.out(rd1_data_i),
      .in(word_out),
      .select(rd1_addr));
   mux_256x32b_to_1x32b mux_rd_port_2
     (.out(rd2_data_i),
      .in(word_out),
      .select(rd2_addr));
   decoder_param #(8,256) decoder_wr_port_0
     (.out(wr0_word_select),
      .in(wr0_addr));
   assign wr_en_word = {256{wr0_en}} & wr0_word_select;
   assign word_in = {256{wr0_data}};
   dff_en rd_port_0_out_flop[31:0]
     (.q(rd0_data),
      .d(rd0_data_i),
      .en(1'b1),
      .clk(clk),
      .rst(1'b0));
   dff_en rd_port_1_out_flop[31:0]
     (.q(rd1_data),
      .d(rd1_data_i),
      .en(1'b1),
      .clk(clk),
      .rst(1'b0));
   dff_en rd_port_2_out_flop[31:0]
     (.q(rd2_data),
      .d(rd2_data_i),
      .en(1'b1),
      .clk(clk),
      .rst(1'b0));
endmodule