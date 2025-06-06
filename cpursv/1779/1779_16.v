
module RegFileWW(rd1data,rd2data,wrdata,rd1addr,rd2addr,wraddr,rd1en,rd2en,
                 wren,wrbyteen,clk);

  output [127:0] rd1data,rd2data;
  input  [0:127] wrdata;
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
        ones = ones-1'd1;
        if (wren) 
          begin
            if (wrbyteen == 16'h1) 
              begin
                operand = wrdata[0:7];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h3) 
              begin
                operand = wrdata[8:15];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h7) 
              begin
                operand = wrdata[16:23];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'hf) 
              begin
                operand = wrdata[24:31];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h1f) 
              begin
                operand = wrdata[32:39];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h3f) 
              begin
                operand = wrdata[40:47];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h7f) 
              begin
                operand = wrdata[48:55];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'hff) 
              begin
                operand = wrdata[56:63];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h1ff) 
              begin
                operand = wrdata[64:71];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h3ff) 
              begin
                operand = wrdata[72:79];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h7ff) 
              begin
                operand = wrdata[80:87];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'hfff) 
              begin
                operand = wrdata[88:95];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h1fff) 
              begin
                operand = wrdata[96:103];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h3fff) 
              begin
                operand = wrdata[104:111];
                result = operand & ones;
                reg_file[wraddr] <= result;
              end
            else if (wrbyteen == 16'h7fff) 
              begin
                operand = wrdata[112:119];
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
          
        if ((rd1addr !== 5'dz) && ((rd1addr !== 5'dx) && rd1en)) 
          begin
            rd1data <= reg_file[rd1addr];
          end
        else 
          begin
            rd1data = 128'dz;
          end
        if ((rd2addr !== 5'dx) && rd2en && (rd2addr !== 5'dz)) 
          begin
            rd2data <= reg_file[rd2addr];
          end
        else 
          begin
            rd2data = 128'dz;
          end
      end
endmodule

