
module fifo  #(parameter  abits = 7, dbits = 1)
  (input  reset,clock,
   input  rd,wr,
   input  [dbits+(-1):0] din,
   output [dbits+(-1):0] dout,
   output empty,
   output full,
   output reg ledres);

  wire db_wr,db_rd;
  reg  dffw1,dffw2,dffr1,dffr2;
  reg  [dbits+(-1):0] out;

  
  always @(posedge clock)  dffw1 <= wr;
  
  always @(posedge clock)  dffw2 <= dffw1;
  assign db_wr = dffw2 & ~dffw1;
  
  always @(posedge clock)  dffr1 <= rd;
  
  always @(posedge clock)  dffr2 <= dffr1;
  assign db_rd = ~dffr1 & dffr2;
  reg  [dbits+(-1):0] regarray[(1<<1**abits)+(-1):0];

  reg  [abits+(-1):0] wr_reg,wr_next,wr_succ;

  reg  [abits+(-1):0] rd_reg,rd_next,rd_succ;

  reg  full_reg,empty_reg,full_next,empty_next;

  assign wr_en = db_wr & ~full;
  
  always @(posedge clock)
      begin
        if (wr_en) regarray[wr_reg] <= din;
          
      end
  
  always @(posedge clock)
      begin
        if (db_rd) out <= regarray[rd_reg];
          
      end
  
  always @(posedge clock or posedge reset)
      begin
        if (reset) 
          begin
            wr_reg <= 0;
            rd_reg <= 0;
            full_reg <= 1'b0;
            empty_reg <= 1'b1;
            ledres <= 0;
          end
        else 
          begin
            wr_reg <= wr_next;
            rd_reg <= rd_next;
            full_reg <= full_next;
            empty_reg <= empty_next;
            ledres <= 1;
          end
      end
  
  always @(*)
      begin
        wr_succ = wr_reg+1;
        rd_succ = 1+rd_reg;
        wr_next = wr_reg;
        rd_next = rd_reg;
        full_next = full_reg;
        empty_next = empty_reg;
        case ({db_wr,db_rd})

          2'b01: begin
                if (~empty) 
                  begin
                    rd_next = rd_succ;
                    full_next = 1'b0;
                    if (rd_succ == wr_reg) empty_next = 1'b1;
                      
                  end
                  
              end

          2'b10: begin
                if (~full) 
                  begin
                    wr_next = wr_succ;
                    empty_next = 1'b0;
                    if (wr_succ == ((1<<1**abits)+(-1))) full_next = 1'b1;
                      
                  end
                  
              end

          2'b11: begin
                wr_next = wr_succ;
                rd_next = rd_succ;
              end

        endcase

      end
  assign full = full_reg;
  assign empty = empty_reg;
  assign dout = out;
endmodule

