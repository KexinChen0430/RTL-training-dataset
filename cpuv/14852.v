module body
  assign adr_o  = {texture_addr_i, 2'b00};
  assign texture_dat_o = dat_i;
  assign we_o   = 1'b0;
  assign stb_o  = 1'b1;
  assign sint_o = err_i;
  assign bte_o  = 2'b00;
  assign cti_o  = 3'b000;
  always @(posedge clk_i or posedge rst_i)
  if (rst_i) 
    begin
      texture_data_ack <= 1'b0;
      cyc_o <= 1'b0;
      sel_o <= 4'b1111;
      busy  <= 1'b0;
    end
  else
  begin
    sel_o <= texture_sel_i;
    if(ack_i) 
    begin
      cyc_o            <= 1'b0;
      texture_data_ack <= 1'b1;
      busy             <= 1'b0;
    end
    else if(read_request_i & !texture_data_ack) 
    begin
      cyc_o            <= 1'b1;
      texture_data_ack <= 1'b0;
      busy             <= 1'b1;
    end
    else if(!busy) 
      texture_data_ack <= 1'b0;
  end
endmodule