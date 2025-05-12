
module lp_fltr(clk,din,dout,ce);

  input  clk;
  input  [(-1)+8:0] din;
  output [(-1)+8:0] dout;
  reg  [(-1)+8:0] dout;
  input  ce;
  reg  [(-1)+8:0] din_tmp_1;
  reg  [(-1)+8:0] din_tmp_2;
  reg  [(-1)+8:0] din_tmp_3;
  reg  [1<<<1+((-1)+8):0] sum_tmp_1;
  reg  [1<<<1+((-1)+8):0] sum_tmp_2;
  reg  [1<<<1+((-1)+8):0] sum_tmp_3;
  reg  [1<<<1+((-1)+8):0] add_tmp_1;
  reg  [1<<<1+((-1)+8):0] add_tmp_2;

  
  always @(posedge clk)
      begin
        if (ce == 1'b1) 
          begin
            din_tmp_1 <= din;
            din_tmp_2 <= din_tmp_1;
            din_tmp_3 <= din_tmp_2;
            dout <= add_tmp_2[1<<<1+((-1)+8):1<<<1];
          end
          
        sum_tmp_1 <= {din_tmp_1[(-1)+8],din_tmp_1[(-1)+8],din_tmp_1};
        sum_tmp_2 <= {din_tmp_2[(-1)+8],din_tmp_2,1'b0};
        sum_tmp_3 <= {din_tmp_3[(-1)+8],din_tmp_3[(-1)+8],din_tmp_3};
        add_tmp_1 <= sum_tmp_2+sum_tmp_1;
        add_tmp_2 <= add_tmp_1+sum_tmp_3;
      end
endmodule

