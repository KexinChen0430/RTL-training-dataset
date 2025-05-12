module mapped_to_0x4000_00xx_addresses (
);
   always@ (posedge clk or negedge reset_)
     if (!reset_)
       mcs_rd_data <= 32'h0000_0000; 
     else if (rnw && gpio_cs && gpio_rdy)
       mcs_rd_data <= {4{gpio_rd_data}}; 
     else if (rnw && disp_cs && disp_rdy)
       mcs_rd_data <= {4{disp_rd_data}}; 
     else if (rnw && uart_cs && uart_rdy)
       mcs_rd_data <= {4{uart_rd_data}}; 
   always@ (posedge clk or negedge reset_)
     if (!reset_)
       mcs_ready <= 1'b0; 
     else if (gpio_cs)
       mcs_ready <= gpio_rdy; 
     else if (disp_cs)
       mcs_ready <= disp_rdy; 
     else if (uart_cs)
       mcs_ready <= uart_rdy; 
     else
       mcs_ready <= &req_timeout_ctr; 
   always@ (posedge clk or negedge reset_)
     if (!reset_)
       req_timeout_ctr <= 10'd0; 
     else if (mcs_ready)
       req_timeout_ctr <= 10'd0; 
     else if (req)
       req_timeout_ctr <= 10'd1; 
     else if (req_timeout_ctr != 10'd0)
       req_timeout_ctr <= req_timeout_ctr + 10'd1; 
endmodule