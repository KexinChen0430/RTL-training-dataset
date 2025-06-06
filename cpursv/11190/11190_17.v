
module mojo_com_logic  #(parameter  ADDR_SPACE = 256)
  (input  clk,
   input  rst,
   input  [ADDR_SPACE_BITS+(-1):0] reg_addr,
   input  write,
   input  new_req,
   input  [7:0] write_value,
   output [7:0] read_value,
   input  in_transaction,
   output [(8*ADDR_SPACE)-1:0] rx_arr,
   output rx_busy,
   output new_rx,
   input  [(8*ADDR_SPACE)-1:0] tx_arr,
   output tx_busy);

  parameter  ADDR_SPACE_BITS = $clog2(ADDR_SPACE);
  parameter  WORD_SIZE = 8;
  parameter  ADDR_BITS = 8*ADDR_SPACE;
  parameter  ADDR_BIT_COUNT = $clog2(ADDR_BITS);
  reg  [(-1)+ADDR_BITS:0] rx_arr_q,rx_arr_d;
  reg  
      rx_busy_q,
      rx_busy_d,
      tx_busy_q,
      tx_busy_d,
      new_rx_q ,
      new_rx_d ;

  assign rx_arr = rx_arr_q;
  assign rx_busy = rx_busy_q;
  assign new_rx = new_rx_q;
  assign tx_busy = tx_busy_q;
  reg  [7:0] read_value_d,read_value_q;

  assign read_value = read_value_q;
  reg  
      old_write_d      ,
      old_write_q      ,
      old_transaction_d,
      old_transaction_q;

  
  always @(*)
      begin
        read_value_d = read_value_q;
        old_write_d = old_write_q;
        old_transaction_d = in_transaction;
        rx_busy_d = in_transaction;
        tx_busy_d = in_transaction;
        new_rx_d = new_rx_q;
        rx_arr_d = rx_arr_q;
        if (new_req) 
          begin
            read_value_d = tx_arr[{reg_addr,3'b0} +: WORD_SIZE];
            if (write) 
              begin
                rx_arr_d[{reg_addr,3'b0} +: WORD_SIZE] = write_value;
              end
              
          end
          
        if (in_transaction) 
          begin
            old_write_d = write;
          end
        else 
          begin
            new_rx_d = old_write_q & old_transaction_q;
          end
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            read_value_q <= 0;
            rx_busy_q <= 0;
            tx_busy_q <= 0;
            new_rx_q <= 0;
            rx_arr_q <= 0;
            old_write_q <= 0;
            old_transaction_q <= 0;
          end
        else 
          begin
            read_value_q <= read_value_d;
            rx_busy_q <= rx_busy_d;
            tx_busy_q <= tx_busy_d;
            new_rx_q <= new_rx_d;
            rx_arr_q <= rx_arr_d;
            old_write_q <= old_write_d;
            old_transaction_q <= old_transaction_d;
          end
      end
endmodule

