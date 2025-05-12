
module regfileww(rd1data,rd2data,wrdata,rd1addr,rd2addr,wraddr,rd1en,rd2en,
                 wren,wbyteen,clk);

  output [0:127] rd1data,rd2data;
  input  [0:127] wrdata;
  input  clk;
  input  wren;
  input  rd1en,rd2en;
  input  [0:4] wraddr,rd1addr,rd2addr;
  input  [0:15] wbyteen;
  reg  [0:127] rd1data,rd2data;
  reg  [0:127] reg_file[0:31];
  reg  [0:127] result,temp;

  
  always @(posedge clk)
      begin
        result = 128'b0;
        temp = 128'b0;
        rd1data = 128'b0;
        rd2data = 128'b0;
        if (wren) 
          begin
            temp = reg_file[wraddr];
            result[0:7] = (wbyteen[0] == 1'b1) ? wrdata[0:7] : temp[0:7];
            result[8:15] = (wbyteen[1] == 1'b1) ? wrdata[8:15] : temp[8:15];
            result[120:127] = (wbyteen[15] == 1'b1) ? wrdata[120:127] : temp[120:127];
            reg_file[wraddr] = result;
          end
          
        rd1data = rd1en ? reg_file[rd1addr] : 128'd0;
        rd2data = rd2en ? reg_file[rd2addr] : 128'd0;
      end
endmodule

