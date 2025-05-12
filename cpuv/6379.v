module ad_jesd_align ( 
  rx_clk, 
  rx_ip_sof, 
  rx_ip_data, 
  rx_sof, 
  rx_data); 
  input           rx_clk; 
  input   [ 3:0]  rx_ip_sof; 
  input   [31:0]  rx_ip_data; 
  output          rx_sof; 
  output  [31:0]  rx_data; 
  reg     [31:0]  rx_ip_data_d = 'd0; 
  reg     [ 3:0]  rx_ip_sof_hold = 'd0; 
  reg             rx_sof = 'd0; 
  reg     [31:0]  rx_data = 'd0; 
  always @(posedge rx_clk) begin 
    rx_ip_data_d <= rx_ip_data; 
    if (rx_ip_sof != 4'd0) begin 
      rx_ip_sof_hold <= rx_ip_sof; 
    end
    rx_sof <= |rx_ip_sof; 
    if (rx_ip_sof_hold[3] == 1'b1) begin 
    end else if (rx_ip_sof_hold[2] == 1'b1) begin 
    end else if (rx_ip_sof_hold[1] == 1'b1) begin 
    end else if (rx_ip_sof_hold[0] == 1'b1) begin 
    end else begin 
    end
  end
endmodule 