
module sha1_w_mem(input  wire clk,
                  input  wire reset_n,
                  input  wire [511:0] block,
                  input  wire init,
                  input  wire next,
                  output wire [31:0] w);

  reg  [31:0] w_mem[0:15];
  reg  [31:0] w_mem00_new;
  reg  [31:0] w_mem01_new;
  reg  [31:0] w_mem15_new;
  reg  w_mem_we;
  reg  [6:0] w_ctr_reg;
  reg  [6:0] w_ctr_new;
  reg  w_ctr_we;
  reg  [31:0] w_tmp;
  reg  [31:0] w_new;

  assign w = w_tmp;
  
  always @(posedge clk or negedge reset_n)
      begin : reg_update
        integer i;

        if (!reset_n) 
          begin
            for (i = 0; i < 16; i = i+1)
                w_mem[i] <= 32'h0;
            w_ctr_reg <= 7'h0;
          end
        else 
          begin
            if (w_mem_we) 
              begin
                w_mem[0] <= w_mem00_new;
                w_mem[15] <= w_mem15_new;
              end
              
            if (w_ctr_we) w_ctr_reg <= w_ctr_new;
              
          end
      end
  
  always @* 
      begin : select_w
        if (w_ctr_reg < 16) w_tmp = w_mem[w_ctr_reg[3:0]];
        else w_tmp = w_new;
      end
  
  always @* 
      begin : w_mem_update_logic
        reg  [31:0] w_0;

        reg  [31:0] w_2;

        reg  [31:0] w_8;

        reg  [31:0] w_13;

        reg  [31:0] w_16;

        w_mem00_new = 32'h0;
        w_mem15_new = 32'h0;
        w_mem_we = 1'h0;
        w_0 = w_mem[0];
        w_2 = w_mem[2];
        w_8 = w_mem[8];
        w_13 = w_mem[13];
        w_16 = ((~(((w_2 | ~w_2) & (((~w_8 | ~w_13) & ((~w_8 | w_8) & w_8)) ^ ((~w_8 | ~w_13) & ((~w_8 | w_8) & w_13)))) ^ ((w_2 | ~w_2) & w_2)) | ((((~w_8 | ~w_13) & w_8) & ~w_2) | (~(((~w_8 | ~w_13) & ((~w_8 | w_8) & w_8)) ^ ((~w_8 | ~w_13) & ((~w_8 | w_8) & w_13))) | ((w_13 & ~w_2) & ~w_8)))) & (((w_2 | ~w_2) & (((~w_8 | ~w_13) & ((~w_8 | w_8) & w_8)) ^ ((~w_8 | ~w_13) & ((~w_8 | w_8) & w_13)))) ^ ((w_2 | ~w_2) & w_2))) ^ ((~(((w_2 | ~w_2) & (((~w_8 | ~w_13) & ((~w_8 | w_8) & w_8)) ^ ((~w_8 | ~w_13) & ((~w_8 | w_8) & w_13)))) ^ ((w_2 | ~w_2) & w_2)) | ((((~w_8 | ~w_13) & w_8) & ~w_2) | (~(((~w_8 | ~w_13) & ((~w_8 | w_8) & w_8)) ^ ((~w_8 | ~w_13) & ((~w_8 | w_8) & w_13))) | ((w_13 & ~w_2) & ~w_8)))) & w_0);
        w_new = {w_16[30:0],w_16[31]};
        if (init) 
          begin
            w_mem00_new = block[511:480];
            w_mem15_new = block[31:0];
            w_mem_we = 1'h1;
          end
          
        if ((w_ctr_reg > 15) && next) 
          begin
            w_mem00_new = w_mem[1];
            w_mem15_new = w_new;
            w_mem_we = 1'h1;
          end
          
      end
  
  always @* 
      begin : w_ctr
        w_ctr_new = 7'h0;
        w_ctr_we = 1'h0;
        if (init) 
          begin
            w_ctr_new = 7'h0;
            w_ctr_we = 1'h1;
          end
          
        if (next) 
          begin
            w_ctr_new = 7'h01+w_ctr_reg;
            w_ctr_we = 1'h1;
          end
          
      end
endmodule

