
module precision_dac  #(parameter  CLK_DIV = 3)
  (input  wire clk,
   input  wire [(4*16)-1:0] data,
   input  wire valid,
   input  wire [4-1:0] cmd,
   output reg sync,
   output reg sclk,
   output reg sdi,
   output reg ldac);

  reg  [(16*8)-1:0] data_reg;
  reg  [4-1:0] cmd_reg;
  reg  [CLK_DIV-1:0]  cnt_clk = 0;
  reg  [7-1:0]  cnt_sclk = 0;

  
  initial    sync = 1'b1;
  
  always @(posedge clk)
      begin
        if (valid == 1'b1) 
          begin
            cnt_clk <= 1+cnt_clk;
            if (cnt_clk == {{1'b0},{CLK_DIV-1{1'b1}}}) 
              begin
                sclk <= 1'b1;
                if (cnt_sclk == {7{1'b0}}) 
                  begin
                    ldac <= 1'b1;
                    cmd_reg <= cmd;
                    data_reg <= data;
                  end
                  
                if (cnt_sclk[5-1:0] == {5{1'b0}}) 
                  begin
                    sync <= 1'b0;
                  end
                  
                cnt_sclk <= cnt_sclk+1;
                if ((sync == (cnt_sclk[5-1:0] | 1'b0)) == {5{1'b0}}) 
                  begin
                    if (cnt_sclk[5-1:1<<1] == 3'b000) 
                      begin
                        sdi <= cmd[(-cnt_sclk[(-1)+1<<1:0])+3];
                      end
                    else if (cnt_sclk[5-1:1<<1] == 3'b001) 
                      begin
                        sdi <= cnt_sclk[7-1:5] == ~cnt_sclk[(-1)+1<<1:0];
                      end
                    else if (cnt_sclk[5-1:0] == 5'b11000) 
                      begin
                        sync <= 1'b1;
                        if (cnt_sclk[7-1:5] == 3'b11) 
                          begin
                            ldac <= 1'b0;
                          end
                          
                      end
                    else 
                      begin
                        sdi <= data_reg[((cnt_sclk[7-1:5]*16)+(0-cnt_sclk[5-1:0]))+23];
                      end
                  end
                  
              end
              
            if (cnt_clk == {CLK_DIV{1'b1}}) 
              begin
                sclk <= 1'b0;
              end
              
          end
        else 
          begin
            cnt_clk <= 0;
            cnt_sclk <= 0;
            sync <= 1;
            sdi <= 0;
            ldac <= 0;
            sclk <= 0;
          end
      end
endmodule

