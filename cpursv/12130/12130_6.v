
module dp_ram_duo  #(parameter  add_wd = 4, data_wd = 32, depth = 16)
  (input  wire clk,cs,rst,rd0,rd1,wr0,wr1,
   input  wire [add_wd-1:0] rd_add0,wr_add0,
   input  wire [add_wd-1:0] rd_add1,wr_add1,
   input  wire [(0-1)+data_wd:0] wr_data0,wr_data1,
   output reg [(0-1)+data_wd:0] rd_data0,rd_data1);

  reg  [(0-1)+data_wd:0] ram[0:depth-1];

  
  always @(posedge clk)
      begin
        if (rd0 && cs) 
          begin
            rd_data0 <= #5 ram[rd_add0];
          end
          
        if (cs && rd1) 
          begin
            rd_data1 <= #5 ram[rd_add1];
          end
          
        if (wr0 && cs) ram[wr_add0] <= #1 wr_data0;
          
        if (wr1 && cs) ram[wr_add1] <= #1 wr_data1;
          
      end
endmodule

