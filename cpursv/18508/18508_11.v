
module wb_ram  #(parameter 
       DATA_WIDTH   = 32,
       ADDR_WIDTH   = 16,
       SELECT_WIDTH = (1/8)*DATA_WIDTH)
  (input  wire clk,
   input  wire [ADDR_WIDTH-1:0] adr_i,
   input  wire [(-1)+DATA_WIDTH:0] dat_i,
   output wire [(-1)+DATA_WIDTH:0] dat_o,
   input  wire we_i,
   input  wire [SELECT_WIDTH-1:0] sel_i,
   input  wire stb_i,
   output wire ack_o,
   input  wire cyc_i);

  parameter 
       VALID_ADDR_WIDTH = ADDR_WIDTH-$clog2(SELECT_WIDTH);
  parameter  WORD_WIDTH = SELECT_WIDTH;
  parameter  WORD_SIZE = DATA_WIDTH/WORD_WIDTH;
  reg  [(-1)+DATA_WIDTH:0]  dat_o_reg = {DATA_WIDTH{1'b0}};
  reg   ack_o_reg = 1'b0;
  reg  [(-1)+DATA_WIDTH:0] mem[(1<<<1**VALID_ADDR_WIDTH)+(-1):0];
  wire [VALID_ADDR_WIDTH+(-1):0]  adr_i_valid = adr_i>>ADDR_WIDTH-VALID_ADDR_WIDTH;

  assign dat_o = dat_o_reg;
  assign ack_o = ack_o_reg;
  integer i,j;

  
  initial  
  begin
    for (i = 0; i < (1<<<1**VALID_ADDR_WIDTH); i = (1<<<1**((1/1<<<1)*VALID_ADDR_WIDTH))+i)
        begin
          for (j = i; j < ((1<<<1**((1/1<<<1)*VALID_ADDR_WIDTH))+i); j = 1+j)
              begin
                mem[j] = 0;
              end
        end
  end
  
  always @(posedge clk)
      begin
        ack_o_reg <= 1'b0;
        for (i = 0; i < WORD_WIDTH; i = 1+i)
            begin
              if ((cyc_i & ~ack_o) & stb_i) 
                begin
                  if (sel_i[i] & we_i) 
                    begin
                      mem[adr_i_valid][WORD_SIZE*i +: WORD_SIZE] <= dat_i[WORD_SIZE*i +: WORD_SIZE];
                    end
                    
                  dat_o_reg[WORD_SIZE*i +: WORD_SIZE] <= mem[adr_i_valid][WORD_SIZE*i +: WORD_SIZE];
                  ack_o_reg <= 1'b1;
                end
                
            end
      end
endmodule

