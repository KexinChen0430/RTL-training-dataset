
module RegFileWW(rd1data,rd2data,wrdata,rd1addr,rd2addr,wraddr,rd1en,rd2en,
                 wren,wrbyteen,clk);

  output [127:0] rd1data,rd2data;
  input  [127:0] wrdata;
  input  clk;
  input  wren;
  input  rd1en,rd2en;
  input  [4:0] wraddr,rd1addr,rd2addr;
  input  [15:0] wrbyteen;
  reg  [127:0] rd1data,rd2data;
  reg  [127:0] reg_file[31:0];
  reg  [127:0] ones;
  reg  [127:0] result;
  reg  [7:0] operand;

  
  always @(posedge clk)
      begin
        ones = 128'd0;
        ones = ones+(-1'd1);
        if (wren) 
          begin
            if (wrbyteen == 16'h1) 
              begin
                operand = wrdata[0:7];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'hffff) 
              begin
                operand = wrdata[120:127];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
              
          end
          
        if (rd1en) 
          begin
            rd1data <= reg_file[rd1addr];
          end
        else 
          begin
            rd1data <= 128'b0;
          end
        if (rd2en) 
          begin
            rd2data <= reg_file[rd2addr];
          end
        else 
          begin
            rd2data <= 128'b0;
          end
      end
endmodule

