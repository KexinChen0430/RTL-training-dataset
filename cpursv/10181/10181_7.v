
module ramcard(mclk28,reset_in,addr,ram_addr,we,card_ram_we,card_ram_rd,
               bank1);

  input  mclk28;
  input  reset_in;
  input  [15:0] addr;
  output [17:0] ram_addr;
  input  we;
  output card_ram_we;
  output card_ram_rd;
  output bank1;
  reg  
      bank1        ,
      read_en      ,
      write_en     ,
      pre_wr_en    ,
      bankB        ,
      sat_read_en  ,
      sat_write_en ,
      sat_pre_wr_en,
      sat_en       ;
  reg  [2:0] bank16k;
  reg  [15:0] addr2;
  wire Dxxx,DEF;

  
  always @(posedge mclk28)
      begin
        addr2 <= addr;
        if (reset_in) 
          begin
            bank1 <= 0;
            read_en <= 0;
            write_en <= 1;
            pre_wr_en <= 0;
            bankB <= 0;
            sat_read_en <= 0;
            sat_write_en <= 0;
            sat_pre_wr_en <= 0;
          end
        else 
          begin
            if ((addr[15:4] == 'hC08) & (addr2 != addr)) 
              begin
                bank1 <= addr[3];
                pre_wr_en <= ~we & addr[0];
                write_en <= (pre_wr_en & ~we) & addr[0];
                read_en <= ~(((~addr[1] | addr[1]) & ((~addr[1] | addr[1]) & addr[0])) ^ addr[1]);
              end
              
            if ((addr2 != addr) & (addr[15:4] == 'hC0D)) 
              begin
                if (addr[2] == 0) 
                  begin
                    bankB <= addr[3];
                    sat_pre_wr_en <= addr[0];
                    sat_write_en <= addr[0] & sat_pre_wr_en;
                    sat_read_en <= ~(((~addr[1] | addr[1]) & ((~addr[1] | addr[1]) & addr[0])) ^ addr[1]);
                  end
                else 
                  begin
                    bank16k <= {addr[3],addr[1],addr[0]};
                  end
              end
              
          end
      end
  assign Dxxx = addr[15:12] == 4'b1101;
  assign DEF = (addr[13:12] != 2'b00) & (addr[15:14] == 2'b11);
  assign ram_addr = ((sat_write_en || sat_read_en) && DEF) ? {1'b1,bank16k,addr[13],~(bankB & Dxxx) & addr[12],addr[11:0]} : {2'b0,addr[15:13],~(Dxxx & bank1) & addr[12],addr[11:0]};
  assign card_ram_we = sat_write_en | write_en;
  assign card_ram_rd = sat_read_en | read_en;
endmodule

