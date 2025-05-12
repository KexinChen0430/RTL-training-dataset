
module wb_dp_ram  #(parameter 
       DATA_WIDTH   = 32,
       ADDR_WIDTH   = 32,
       SELECT_WIDTH = DATA_WIDTH/8)
  (input  wire a_clk,
   input  wire [(-1)+ADDR_WIDTH:0] a_adr_i,
   input  wire [(-1)+DATA_WIDTH:0] a_dat_i,
   output wire [(-1)+DATA_WIDTH:0] a_dat_o,
   input  wire a_we_i,
   input  wire [SELECT_WIDTH+(-1):0] a_sel_i,
   input  wire a_stb_i,
   output wire a_ack_o,
   input  wire a_cyc_i,
   input  wire b_clk,
   input  wire [(-1)+ADDR_WIDTH:0] b_adr_i,
   input  wire [(-1)+DATA_WIDTH:0] b_dat_i,
   output wire [(-1)+DATA_WIDTH:0] b_dat_o,
   input  wire b_we_i,
   input  wire [SELECT_WIDTH+(-1):0] b_sel_i,
   input  wire b_stb_i,
   output wire b_ack_o,
   input  wire b_cyc_i);

  parameter 
       VALID_ADDR_WIDTH = (0-$clog2(SELECT_WIDTH))+ADDR_WIDTH;
  parameter  WORD_WIDTH = SELECT_WIDTH;
  parameter  WORD_SIZE = DATA_WIDTH/WORD_WIDTH;
  reg  [(-1)+DATA_WIDTH:0]  a_dat_o_reg = {DATA_WIDTH{1'b0}};
  reg   a_ack_o_reg = 1'b0;
  reg  [(-1)+DATA_WIDTH:0]  b_dat_o_reg = {DATA_WIDTH{1'b0}};
  reg   b_ack_o_reg = 1'b0;
  reg  [(-1)+DATA_WIDTH:0] mem[(2**VALID_ADDR_WIDTH)-1:0];
  wire [VALID_ADDR_WIDTH-1:0] 
       a_adr_i_valid = a_adr_i>>(-VALID_ADDR_WIDTH)+ADDR_WIDTH;
  wire [VALID_ADDR_WIDTH-1:0] 
       b_adr_i_valid = b_adr_i>>(-VALID_ADDR_WIDTH)+ADDR_WIDTH;

  assign a_dat_o = a_dat_o_reg;
  assign a_ack_o = a_ack_o_reg;
  assign b_dat_o = b_dat_o_reg;
  assign b_ack_o = b_ack_o_reg;
  integer i;

  
  initial  
  begin
    for (i = 0; i < (2**VALID_ADDR_WIDTH); i = 1+i)
        begin
          mem[i] = 0;
        end
  end
  
  always @(posedge a_clk)
      begin
        a_ack_o_reg <= 1'b0;
        for (i = 0; i < WORD_WIDTH; i = 1+i)
            begin
              if (a_cyc_i & (~a_ack_o & a_stb_i)) 
                begin
                  if (a_we_i & a_sel_i[i]) 
                    begin
                      mem[a_adr_i_valid][i*WORD_SIZE +: WORD_SIZE] <= a_dat_i[i*WORD_SIZE +: WORD_SIZE];
                    end
                    
                  a_dat_o_reg[i*WORD_SIZE +: WORD_SIZE] <= mem[a_adr_i_valid][i*WORD_SIZE +: WORD_SIZE];
                  a_ack_o_reg <= 1'b1;
                end
                
            end
      end
  
  always @(posedge b_clk)
      begin
        b_ack_o_reg <= 1'b0;
        for (i = 0; i < WORD_WIDTH; i = 1+i)
            begin
              if (~b_ack_o & (b_stb_i & b_cyc_i)) 
                begin
                  if (b_we_i & b_sel_i[i]) 
                    begin
                      mem[b_adr_i_valid][i*WORD_SIZE +: WORD_SIZE] <= b_dat_i[i*WORD_SIZE +: WORD_SIZE];
                    end
                    
                  b_dat_o_reg[i*WORD_SIZE +: WORD_SIZE] <= mem[b_adr_i_valid][i*WORD_SIZE +: WORD_SIZE];
                  b_ack_o_reg <= 1'b1;
                end
                
            end
      end
endmodule

