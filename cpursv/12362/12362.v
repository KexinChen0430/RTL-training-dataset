
module segDisplayDriver(clk,data,out_dig,out_seg);

  input  clk;
  input  [15:0] data;
  output [3:0] out_dig;
  output [7:0] out_seg;
  reg  [31:0] clk_cnt;
  reg  clk_500Hz;

  
  always @(posedge clk)
      if (clk_cnt == 32'd200_000) 
        begin
          clk_cnt <= 1'b0;
          clk_500Hz <= ~clk_500Hz;
        end
      else clk_cnt <= clk_cnt+1'b1;
  reg  [3:0]  dig_ctrl = 4'b1110;

  
  always @(posedge clk_500Hz)
      dig_ctrl <= {dig_ctrl[2:0],dig_ctrl[3]};
  reg  [4:0] seg_ctrl;

  
  always @(dig_ctrl)
      case (dig_ctrl)

        4'b1110: seg_ctrl = {1'b0,data[3:0]};

        4'b1101: seg_ctrl = {1'b0,data[7:4]};

        4'b1011: seg_ctrl = {1'b0,data[11:8]};

        4'b0111: seg_ctrl = {1'b0,data[15:12]};

        default: seg_ctrl = 5'h1f;

      endcase

  reg  [7:0] seg_reg;

  
  always @(seg_ctrl)
      case (seg_ctrl)

        default: seg_reg = 8'b1111_1111;

      endcase

  assign out_dig = dig_ctrl;
  assign out_seg = seg_reg;
endmodule

