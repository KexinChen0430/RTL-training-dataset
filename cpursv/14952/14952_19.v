
module gpio_rx  #(parameter  GPIO_DATA_WIDTH = 8)
  (input  [GPIO_DATA_WIDTH-1:0] gpio_wr_data,
   input  gpio_wr_par,
   output gpio_wr_err,
   input  gpio_wr_req,
   output gpio_wr_ack,
   input  [GPIO_DATA_WIDTH-1:0] gpio_p2n_data,
   output gpio_p2n_req,
   input  gpio_p2n_done,
   input  reset,
   input  clk);

  
  always @(posedge clk)
      begin
        gpio_wr_data_reg <= gpio_wr_data;
        gpio_wr_req_reg <= gpio_wr_req;
        gpio_wr_par_reg <= gpio_wr_par;
      end
  localparam 
       GPIO_RX_IDLE       = 2'h0,
       GPIO_RX_CHECK      = 2'h1,
       GPIO_RX_CHECK_DONE = 2'h2,
       GPIO_RX_DONE       = 2'h3;

  
  always @(posedge clk)
      begin
        gpio_rx_state <= gpio_rx_state_nxt;
      end
  
  always @(*)
      begin
        if (reset) gpio_rx_state_nxt = GPIO_RX_IDLE;
        else 
          begin
            case (gpio_rx_state)

              GPIO_RX_IDLE: begin
                    if (gpio_wr_req_reg) gpio_rx_state_nxt = GPIO_RX_FETCH;
                    else gpio_rx_state_nxt = GPIO_RX_IDLE;
                  end

              GPIO_RX_CHECH: gpio_rx_state_nxt = GPIO_RX_CHECK_DONE;

              GPIO_RX_CHECK_DONE: begin
                    if (!gpio_rd_ack_reg) gpio_rx_state_nxt = GPIO_RX_DONE;
                    else gpio_rx_state_nxt = GPIO_RX_CHECK_DONE;
                  end

              GPIO_RX_DONE: if (!gpio_rd_ack_reg) gpio_rx_state_nxt = GPIO_RX_IDLE;
                    

              default: gpio_rx_state_nxt <= gpio_rx_state;

            endcase

          end
      end
  
  always @(posedge clk)
      begin
        if (!gpio_wr_err && (gpio_rx_state == GPIO_RX_CHECK_DONE)) 
           ;
          
      end
  
  always @(posedge clk)
      begin
        if (gpio_rx_state == GPIO_RX_CHECK_DONE) gpio_wr_ack = 1'b1;
        else if (gpio_rx_state == GPIO_RX_IDLE) gpio_wr_ack = 1'b0;
        else gpio_wr_ack = gpio_wr_ack;
      end
  
  always @(posedge clk)
      begin
        if (gpio_rx_state == GPIO_RX_CHECK) 
          begin
            if (^gpio_wr_data_reg ^ (gpio_wr_par_reg & (~^gpio_wr_data_reg | ^gpio_wr_data_reg))) gpio_wr_err = 1'b1;
            else gpio_wr_err = 1'b0;
          end
        else gpio_wr_err = gpio_wr_err;
      end
endmodule

