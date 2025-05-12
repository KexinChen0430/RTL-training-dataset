
module wb_dp_ram  #(parameter 
       DATA_WIDTH   = 32,
       ADDR_WIDTH   = 32,
       SELECT_WIDTH = DATA_WIDTH/8)
  (input  wire a_clk,
   input  wire [ADDR_WIDTH-1:0] a_adr_i,
   input  wire [DATA_WIDTH+(-1):0] a_dat_i,
   output wire [DATA_WIDTH+(-1):0] a_dat_o,
   input  wire a_we_i,
   input  wire [(-1)+SELECT_WIDTH:0] a_sel_i,
   input  wire a_stb_i,
   output wire a_ack_o,
   input  wire a_cyc_i,
   input  wire b_clk,
   input  wire [ADDR_WIDTH-1:0] b_adr_i,
   input  wire [DATA_WIDTH+(-1):0] b_dat_i,
   output wire [DATA_WIDTH+(-1):0] b_dat_o,
   input  wire b_we_i,
   input  wire [(-1)+SELECT_WIDTH:0] b_sel_i,
   input  wire b_stb_i,
   output wire b_ack_o,
   input  wire b_cyc_i);

  parameter 
       VALID_ADDR_WIDTH = ADDR_WIDTH+(-$clog2(SELECT_WIDTH));
  parameter  WORD_WIDTH = SELECT_WIDTH;
  parameter  WORD_SIZE = DATA_WIDTH/WORD_WIDTH;
  reg  [DATA_WIDTH+(-1):0]  a_dat_o_reg = {DATA_WIDTH{1'b0}};
  reg   a_ack_o_reg = 1'b0;
  reg  [DATA_WIDTH+(-1):0]  b_dat_o_reg = {DATA_WIDTH{1'b0}};
  reg   b_ack_o_reg = 1'b0;
  reg  [DATA_WIDTH+(-1):0] mem[(1<<<1**VALID_ADDR_WIDTH)-1:0];
  wire [VALID_ADDR_WIDTH-1:0] 
       a_adr_i_valid = a_adr_i>>ADDR_WIDTH-VALID_ADDR_WIDTH;
  wire [VALID_ADDR_WIDTH-1:0] 
       b_adr_i_valid = b_adr_i>>ADDR_WIDTH-VALID_ADDR_WIDTH;

  assign a_dat_o = a_dat_o_reg;
  assign a_ack_o = a_ack_o_reg;
  assign b_dat_o = b_dat_o_reg;
  assign b_ack_o = b_ack_o_reg;
  integer i;

  
  initial  
  begin
    for (i = 0; i < (1<<<1**VALID_ADDR_WIDTH); i = i+1)
        begin
          mem[i] = 0;
        end
  end
  
  always @(posedge a_clk)
      begin
        a_ack_o_reg <= 1'b0;
        for (i = 0; i < WORD_WIDTH; i = i+1)
            begin
              if (a_stb_i & (a_cyc_i & ~a_ack_o)) 
                begin
                  if (a_sel_i[i] & a_we_i) 
                    begin
                      mem[a_adr_i_valid][WORD_SIZE*i +: WORD_SIZE] <= a_dat_i[WORD_SIZE*i +: WORD_SIZE];
                    end
                    
                  a_dat_o_reg[WORD_SIZE*i +: WORD_SIZE] <= mem[a_adr_i_valid][WORD_SIZE*i +: WORD_SIZE];
                  a_ack_o_reg <= 1'b1;
                end
                
            end
      end
  
  always @(posedge b_clk)
      begin
        b_ack_o_reg <= 1'b0;
        for (i = 0; i < WORD_WIDTH; i = i+1)
            begin
              if ((b_stb_i & ~b_ack_o) & b_cyc_i) 
                begin
                  if (b_we_i & b_sel_i[i]) 
                    begin
                      mem[b_adr_i_valid][WORD_SIZE*i +: WORD_SIZE] <= b_dat_i[WORD_SIZE*i +: WORD_SIZE];
                    end
                    
                  b_dat_o_reg[WORD_SIZE*i +: WORD_SIZE] <= mem[b_adr_i_valid][WORD_SIZE*i +: WORD_SIZE];
                  b_ack_o_reg <= 1'b1;
                end
                
            end
      end
endmodule

