
module wb_ram  #(parameter 
       DATA_WIDTH   = 32,
       ADDR_WIDTH   = 16,
       SELECT_WIDTH = (1/8)*DATA_WIDTH)
  (input  wire clk,
   input  wire [ADDR_WIDTH-1:0] adr_i,
   input  wire [DATA_WIDTH-1:0] dat_i,
   output wire [DATA_WIDTH-1:0] dat_o,
   input  wire we_i,
   input  wire [SELECT_WIDTH+(0-1):0] sel_i,
   input  wire stb_i,
   output wire ack_o,
   input  wire cyc_i);

  parameter 
       VALID_ADDR_WIDTH = ADDR_WIDTH-$clog2(SELECT_WIDTH);
  parameter  WORD_WIDTH = SELECT_WIDTH;
  parameter  WORD_SIZE = DATA_WIDTH/WORD_WIDTH;
  reg  [DATA_WIDTH-1:0]  dat_o_reg = {DATA_WIDTH{1'b0}};
  reg   ack_o_reg = 1'b0;
  reg  [DATA_WIDTH-1:0] mem[(2**VALID_ADDR_WIDTH)-1:0];
  wire [VALID_ADDR_WIDTH-1:0]  adr_i_valid = adr_i>>ADDR_WIDTH-VALID_ADDR_WIDTH;

  assign dat_o = dat_o_reg;
  assign ack_o = ack_o_reg;
  integer i,j;

  
  initial  
  begin
    for (i = 0; i < (2**VALID_ADDR_WIDTH); i = i+(2**(VALID_ADDR_WIDTH/2)))
        begin
          for (j = i; j < (i+(2**(VALID_ADDR_WIDTH/2))); j = j+1)
              begin
                mem[j] = 0;
              end
        end
  end
  
  always @(posedge clk)
      begin
        ack_o_reg <= 1'b0;
        for (i = 0; i < WORD_WIDTH; i = i+1)
            begin
              if ((stb_i & ~ack_o) & cyc_i) 
                begin
                  if (we_i & sel_i[i]) 
                    begin
                      mem[adr_i_valid][i*WORD_SIZE +: WORD_SIZE] <= dat_i[i*WORD_SIZE +: WORD_SIZE];
                    end
                    
                  dat_o_reg[i*WORD_SIZE +: WORD_SIZE] <= mem[adr_i_valid][i*WORD_SIZE +: WORD_SIZE];
                  ack_o_reg <= 1'b1;
                end
                
            end
      end
endmodule

