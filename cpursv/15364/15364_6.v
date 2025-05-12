
module lp_fltr_v4(clk,din,dout_1,dout_2,nd);

  input  clk;
  input  [8+(0-1):0] din;
  output [8+(0-1):0] dout_1;
  reg  [8+(0-1):0] dout_1;
  output [8+(0-1):0] dout_2;
  reg  [8+(0-1):0] dout_2;
  input  nd;
  reg  [8+(0-1):0] din_1_reg;
  wire [8+(0-1):0] buff_out_1;
  wire [8+(0-1):0] buff_out_2;
  reg  [8+(0-1):0] din_2_reg;
  reg  [8+(0-1):0] din_3_reg;
  reg  [1+8:0] add_tmp_1;
  reg  [1+8:0] add_tmp_2;

  my_fifo_89 ints_fifo_1(clk,din,buff_out_1,nd);
  my_fifo_89 ints_fifo_2(clk,buff_out_1,buff_out_2,nd);
  
  always @(posedge clk)
      begin
        if (nd == 1'b1) 
          begin
            din_1_reg <= din;
            din_2_reg <= buff_out_1;
            din_3_reg <= buff_out_2;
            dout_1 <= din;
            dout_2 <= add_tmp_2[1+8:2];
          end
          
        add_tmp_1 <= {din_3_reg[8+(0-1)],din_3_reg[8+(0-1)],din_3_reg}+{din_1_reg[8+(0-1)],din_1_reg[8+(0-1)],din_1_reg};
        add_tmp_2 <= {din_2_reg[8+(0-1)],din_2_reg,1'b0}+add_tmp_1;
      end
endmodule

