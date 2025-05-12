
module sync_fifo  #(parameter 
       WIDTH    = 32,
       DEPTH    = 16,
       STYLE    = SRL,
       AFASSERT = DEPTH+(0-1),
       AEASSERT = 1,
       ADDRW    = (DEPTH <= (1+1)) ? 1 : 
(DEPTH <= 4) ? (1+1) : 
(DEPTH <= 8) ? 3 : 
(DEPTH <= 16) ? 4 : 
(DEPTH <= 32) ? 5 : 
(DEPTH <= 64) ? 6 : 
(DEPTH <= 128) ? 7 : 
(DEPTH <= 256) ? 8 : 
(DEPTH <= 512) ? 9 : 
(DEPTH <= 1024) ? 10 : 
(DEPTH <= 2048) ? 11 : 
(DEPTH <= 4096) ? 12 : 
(DEPTH <= 8192) ? 13 : 
(DEPTH <= 16384) ? 14 : -1)
  (input  wire clk,
   input  wire rst_n,
   input  wire [WIDTH+(0-1):0] din,
   output wire [WIDTH+(0-1):0] dout,
   input  wire wr_en,
   input  wire rd_en,
   output reg full,
   output reg afull,
   output wire empty,
   output wire aempty,
   output wire [ADDRW:0] data_count);

  parameter  TCQ = 1;
  reg  [WIDTH+(0-1):0] regBank[DEPTH+(0-1):0];
  wire [WIDTH+(0-1):0] dout_int;
  reg  [ADDRW:0] data_count_int;
  reg  [(0-1)+ADDRW:0] data_count_m1;
  reg  empty_int;
  reg  aempty_int;
  wire rd_en_int;
  wire wr_en_int;
  integer i;

  assign rd_en_int = !empty_int && rd_en;
  assign wr_en_int = wr_en && !full;
  assign dout = dout_int;
  assign empty = empty_int;
  assign aempty = aempty_int;
  assign data_count = data_count_int;
  
  generate
      if (STYLE == SRL) 
        begin : srl_style_fifo
          
          initial  
          begin
            for (i = 0; i < (WIDTH+(0-1)); i = i+1)
                regBank[i] = 0;
          end
          
          always @(posedge clk)
              begin
                if (wr_en_int) 
                  begin
                    for (i = DEPTH+(0-1); i > 0; i = i-1)
                        regBank[i] <= #TCQ regBank[i-1];
                    regBank[0] <= #TCQ din;
                  end
                  
              end
          wire [(0-1)+ADDRW:0] 
       data_count_int_trunc = data_count_int[(0-1)+ADDRW:0];

          assign dout_int = regBank[data_count_int_trunc];
        end
      else 
        begin : reg_style_fifo
          reg  [WIDTH+(0-1):0] dout_reg;

          
          always @(posedge clk or negedge rst_n)
              begin
                if (!rst_n) 
                  for (i = DEPTH+(0-1); i >= 0; i = i-1)
                      regBank[i] <= #TCQ 'b0;
                else if (wr_en_int) 
                  begin
                    for (i = DEPTH+(0-1); i > 0; i = i-1)
                        regBank[i] <= #TCQ regBank[i-1];
                    regBank[0] <= #TCQ din;
                  end
                  
              end
          
          always @(posedge clk or negedge rst_n)
              begin
                if (!rst_n) dout_reg <= #TCQ 'b0;
                else if (rd_en_int) dout_reg <= #TCQ regBank[data_count_m1];
                  
              end
          assign dout_int = dout_reg;
        end
  endgenerate

  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            data_count_int <= #TCQ 'h0;
            data_count_m1 <= #TCQ {ADDRW{1'b1}};
            full <= #TCQ 1'b0;
            afull <= #TCQ 1'b0;
          end
        else if (!wr_en_int && rd_en_int) 
          begin
            data_count_int <= #TCQ data_count_int+(0-1);
            data_count_m1 <= #TCQ (0-1)+data_count_m1;
            full <= #TCQ 1'b0;
            if (data_count_int == AFASSERT[ADDRW:0]) afull <= #TCQ 1'b0;
              
          end
        else if (!rd_en_int && wr_en_int) 
          begin
            data_count_int <= #TCQ 1+data_count_int;
            data_count_m1 <= #TCQ 1+data_count_m1;
            if (data_count_int == (DEPTH+(0-1))) full <= #TCQ 1'b1;
              
            if (data_count_int == (AFASSERT+(0-1))) afull <= #TCQ 1'b1;
              
          end
          
      end
  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            empty_int <= #TCQ 1'b1;
            aempty_int <= #TCQ 1'b1;
          end
        else if (!wr_en_int && rd_en_int) 
          begin
            if (data_count_int == 1) empty_int <= #TCQ 1'b1;
              
            if (data_count_int == (AEASSERT+1)) aempty_int <= #TCQ 1'b1;
              
          end
        else if (!rd_en_int && wr_en_int) 
          begin
            empty_int <= #TCQ 1'b0;
            if (data_count_int == AEASSERT) aempty_int <= #TCQ 1'b0;
              
          end
          
      end
endmodule

