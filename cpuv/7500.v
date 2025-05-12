module control; 
always @(posedge clk)
    if (rst)    i2c_cmd_valid <= 1'b0; 
    else case (fsm) 
    SCAN_I2C_WR:  i2c_cmd_valid <= i2c_cmd_ready;
    SCAN_I2C_WRn: i2c_cmd_valid <= i2c_cmd_ready;
    SCAN_I2C_SP:  i2c_cmd_valid <= i2c_cmd_ready;
    SCAN_I2C_SPn: i2c_cmd_valid <= i2c_cmd_ready;
    default:      i2c_cmd_valid <= 1'b0; 
    endcase
always @(posedge clk)
    if (rst)      i2c_cmd_write <= 1'b0; 
    else case (fsm) 
    SCAN_I2C_WR:  i2c_cmd_write <= i2c_cmd_ready;
    SCAN_I2C_WRn: i2c_cmd_write <= i2c_cmd_ready;
    default:      i2c_cmd_write <= 1'b0; 
    endcase
always @(posedge clk)
    if (rst)      i2c_cmd_stop <= 1'b0; 
    else case (fsm) 
    SCAN_I2C_SP:  i2c_cmd_stop <= i2c_cmd_ready;
    SCAN_I2C_SPn: i2c_cmd_stop <= i2c_cmd_ready;
    default:      i2c_cmd_stop <= 1'b0; 
    endcase
reg did_ack; 
always @(posedge clk)
    if (rst)                  did_ack <= 1'b0; 
    else if(i2c_dat_in_ready) did_ack <= !i2c_missed_ack; 
    else                      did_ack <= did_ack; 
always @(posedge clk)
    case (fsm) 
    SCAN_IDLE:  if(i_stb) i2c_cmd_address <= i_adr; 
                else      i2c_cmd_address <= i2c_cmd_address; 
    default:    i2c_cmd_address <= i2c_cmd_address; 
    endcase
always @(posedge clk)
    if (rst)    i_bsy <= 1'b0; 
    else case (fsm) 
    SCAN_IDLE:  i_bsy <= i_stb; 
    SCAN_OUT:   i_bsy <= 1'b0; 
    default:    i_bsy <= i_bsy; 
    endcase
always @(posedge clk)
    if (rst)    o_stb <= 1'b0; 
    else case (fsm) 
    SCAN_OUT:   o_stb <= 1'b1; 
    default:    o_stb <= 1'b0; 
    endcase
always @(posedge clk)
    case (fsm) 
    SCAN_OUT:   o_ack <= did_ack; 
    default:    o_ack <= o_ack; 
    endcase
endmodule 