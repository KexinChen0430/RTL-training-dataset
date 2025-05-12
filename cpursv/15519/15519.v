
module ge_1000baseX_mdio  #(parameter  PHY_ADDR = 5'b00000)
  (input  reset,
   input  mdc,
   input  mdio,
   output mdio_out,
   output mdio_oe,
   output [4:0] data_addr,
   input  [15:0] data_rd,
   output [15:0] data_wr,
   output reg strobe_wr);

  localparam 
       S_PREAMBLE  = 0,
       S_ST        = 1,
       S_OP_CODE   = 2,
       S_PHY_ADDR  = 3,
       S_REG_ADDR  = 4,
       S_TA        = 5,
       S_WR_DATA   = 6,
       S_RD_DATA   = 7,
       S_WR_COMMIT = 8;
  reg  [3:0] present,next;
  reg  [5:0] preamble_cnt;

  assign preamble_match = preamble_cnt == 31;
  
  always @(posedge mdc or posedge reset)
      if (reset) preamble_cnt <= 0;
      else 
        preamble_cnt <= (mdio & ~preamble_match) ? (preamble_cnt+1) : 
                       (mdio & preamble_match) ? preamble_cnt : 0;
  reg  pos_cnt_inc;

  reg  [4:0] pos_cnt;

  
  always @(posedge mdc or posedge reset)
      if (reset) pos_cnt <= 0;
      else pos_cnt <= pos_cnt_inc ? (pos_cnt+1) : 0;
  assign op_code_done = pos_cnt == 1;
  assign phy_addr_done = pos_cnt == 6;
  assign reg_addr_done = pos_cnt == 11;
  assign ta0_done = pos_cnt == 12;
  assign ta1_done = pos_cnt == 13;
  assign data_done = pos_cnt == 29;
  reg  st;

  reg  st_latch;

  
  always @(posedge mdc or posedge reset)
      if (reset) st <= 0;
      else if (st_latch) st <= mdio;
        
  assign st_match = ~st & mdio;
  reg  [1:0] op_code;

  reg  op_code_shift;

  
  always @(posedge mdc or posedge reset)
      if (reset) op_code <= 0;
      else if (op_code_shift) op_code <= {op_code[0],mdio};
        
  assign op_is_rd = op_code == 2'b10;
  assign op_is_wr = op_code == 2'b01;
  assign op_is_invalid = ~op_is_rd & ~op_is_wr;
  reg  [4:0] phy_addr;

  reg  phy_addr_shift;

  
  always @(posedge mdc or posedge reset)
      if (reset) phy_addr <= 0;
      else if (phy_addr_shift) phy_addr <= {phy_addr[3:0],mdio};
        
  assign phy_addr_match = phy_addr == PHY_ADDR;
  reg  [4:0] reg_addr;

  reg  reg_addr_shift;

  
  always @(posedge mdc or posedge reset)
      if (reset) reg_addr <= 0;
      else if (reg_addr_shift) reg_addr <= {reg_addr[3:0],mdio};
        
  assign data_addr = reg_addr;
  reg  [15:0] data_in;

  reg  data_in_shift;

  
  always @(posedge mdc or posedge reset)
      if (reset) data_in <= 0;
      else if (data_in_shift) data_in <= {data_in[14:0],mdio};
        
  assign data_wr = data_in;
  reg  [15:0] data_out;

  reg  data_out_load,data_out_shift;

  
  always @(posedge mdc or posedge reset)
      if (reset) data_out <= 0;
      else if (data_out_load) data_out <= data_rd;
      else if (data_out_shift) data_out <= {data_out[14:0],1'b0};
        
  assign mdio_oe = (ta1_done & op_is_rd) | data_out_shift;
  assign mdio_out = (ta0_done & op_is_rd) ? 1'bz : 
                    (ta1_done & op_is_rd) ? 1'b0 : data_out[15];
  
  always @(posedge mdc or posedge reset)
      present <= reset ? S_PREAMBLE : next;
  
  always @* 
      begin
        next = present;
        pos_cnt_inc = 0;
        st_latch = 0;
        op_code_shift = 0;
        phy_addr_shift = 0;
        reg_addr_shift = 0;
        data_in_shift = 0;
        data_out_load = 0;
        data_out_shift = 0;
        strobe_wr = 0;
        case (present)

          S_PREAMBLE: begin
                next = (preamble_match & ~mdio) ? S_ST : S_PREAMBLE;
              end

          S_ST: begin
                next = mdio ? S_OP_CODE : S_PREAMBLE;
              end

          S_OP_CODE: begin
                pos_cnt_inc = 1;
                op_code_shift = 1;
                next = op_code_done ? S_PHY_ADDR : S_OP_CODE;
              end

          S_PHY_ADDR: begin
                pos_cnt_inc = 1;
                phy_addr_shift = 1;
                next = phy_addr_done ? S_REG_ADDR : S_PHY_ADDR;
              end

          S_REG_ADDR: begin
                if (phy_addr_match) 
                  begin
                    pos_cnt_inc = 1;
                    reg_addr_shift = 1;
                    next = reg_addr_done ? S_TA : S_REG_ADDR;
                  end
                else next = S_PREAMBLE;
              end

          S_TA: begin
                pos_cnt_inc = 1;
                if (ta1_done) 
                  begin
                    data_out_load = op_is_rd;
                    next = op_is_rd ? S_RD_DATA : 
                           op_is_wr ? S_WR_DATA : S_PREAMBLE;
                  end
                  
              end

          S_WR_DATA: begin
                pos_cnt_inc = 1;
                data_in_shift = 1;
                next = data_done ? S_WR_COMMIT : S_WR_DATA;
              end

          S_RD_DATA: begin
                pos_cnt_inc = 1;
                data_out_shift = 1;
                next = data_done ? S_PREAMBLE : S_RD_DATA;
              end

          S_WR_COMMIT: begin
                strobe_wr = 1;
                next = S_PREAMBLE;
              end

        endcase

      end
endmodule

