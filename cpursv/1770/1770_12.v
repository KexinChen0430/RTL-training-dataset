
module serial_wb_wbmaster(input  wire clk_i,
                          input  wire rst_i,
                          input  wire [7:0] data_i,
                          output reg [7:0] data_o,
                          input  wire writestrobe_i,
                          input  wire [7:0] address_i,
                          input  wire [31:0] wbm_dat_i,
                          output reg [31:0] wbm_dat_o,
                          input  wire wbm_ack_i,
                          output reg [31:0] wbm_adr_o,
                          output reg wbm_cyc_o,
                          input  wire wbm_err_i,
                          output wire wbm_lock_o,
                          input  wire wbm_rty_i,
                          output reg [3:0] wbm_sel_o,
                          output reg wbm_stb_o,
                          output reg wbm_we_o);

  reg  [7:0] statusreg_r;
  reg  [7:0] next_statusreg;
  reg  [31:0] read_reg_r;
  reg  [31:0] next_read_reg;

  assign wbm_lock_o = 0;
  
  always @(posedge clk_i)
      begin
        if (rst_i == 1'b1) 
          begin
            wbm_adr_o <= 32'b0;
          end
        else if (writestrobe_i) 
          begin
            case (address_i[3:0])

              4'd0: wbm_adr_o[7:0] <= data_i;

              4'd1: wbm_adr_o[15:8] <= data_i;

              4'd2: wbm_adr_o[23:16] <= data_i;

              4'd3: wbm_adr_o[31:24] <= data_i;

            endcase

          end
          
      end
  
  always @(posedge clk_i)
      begin
        if (rst_i == 1'b1) 
          begin
            wbm_dat_o <= 32'b0;
          end
        else if (writestrobe_i) 
          begin
            case (address_i[3:0])

              4'd4: wbm_dat_o[7:0] <= data_i;

              4'd5: wbm_dat_o[15:8] <= data_i;

              4'd6: wbm_dat_o[23:16] <= data_i;

              4'd7: wbm_dat_o[31:24] <= data_i;

            endcase

          end
          
      end
  reg  [1:0] next_wb_state;

  reg  [1:0] wb_state_r;

  wire cycle_terminated;

  assign cycle_terminated = wbm_rty_i || (wbm_ack_i || wbm_err_i);
  wire ctrl_write;

  assign ctrl_write = writestrobe_i && (address_i[3:0] == 4'd8);
  
  always @(address_i or statusreg_r)
      begin
        case (address_i[3:0])

          4'd4: data_o = read_reg_r[7:0];

          4'd5: data_o = read_reg_r[15:8];

          4'd6: data_o = read_reg_r[23:16];

          4'd7: data_o = read_reg_r[31:24];

          default: data_o = statusreg_r;

        endcase

      end
  
  always @(ctrl_write or cycle_terminated or data_i or statusreg_r or wb_state_r or wbm_err_i or wbm_rty_i)
      begin
        next_wb_state = wb_state_r;
        wbm_cyc_o = next_wb_state != 2'b00;
        wbm_stb_o = next_wb_state != 2'b00;
        next_statusreg = statusreg_r;
        wbm_we_o = statusreg_r[3];
        wbm_sel_o = statusreg_r[7:4];
        next_read_reg = read_reg_r;
        if (!data_i[0] && ctrl_write) 
          begin
            next_wb_state = 2'b00;
            wbm_cyc_o = 0;
            wbm_stb_o = 0;
            next_statusreg = {data_i[7:3],3'b000};
          end
        else if (ctrl_write && ((wb_state_r == 2'b00) && data_i[0])) 
          begin
            wbm_cyc_o = 1;
            wbm_stb_o = 1;
            next_statusreg = {data_i[7:3],3'b001};
            wbm_we_o = data_i[3];
            wbm_sel_o = data_i[7:4];
            if (cycle_terminated) 
              begin
                next_wb_state = 2'b00;
                next_statusreg[0] = 0;
                next_statusreg[1] = wbm_err_i;
                next_statusreg[2] = wbm_rty_i;
                if (!data_i[3]) 
                  begin
                    next_read_reg = wbm_dat_i;
                  end
                  
              end
            else 
              begin
                if (data_i[3]) 
                  begin
                    next_wb_state = 2'b10;
                  end
                else 
                  begin
                    next_wb_state = 2'b01;
                  end
              end
          end
        else if (cycle_terminated && (wb_state_r != 2'b00)) 
          begin
            next_wb_state = 2'b00;
            next_statusreg[0] = 0;
            next_statusreg[1] = wbm_err_i;
            next_statusreg[2] = wbm_rty_i;
            if (wb_state_r == 2'b01) 
              begin
                next_read_reg = wbm_dat_i;
              end
              
          end
          
      end
  
  always @(posedge clk_i)
      begin
        if (rst_i == 1'b1) 
          begin
            wb_state_r <= 2'b00;
            statusreg_r <= 0;
            read_reg_r <= 0;
          end
        else 
          begin
            wb_state_r <= next_wb_state;
            statusreg_r <= next_statusreg;
            read_reg_r <= next_read_reg;
          end
      end
endmodule

