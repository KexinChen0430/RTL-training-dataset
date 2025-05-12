
module uart_tx(input  clk,
               input  send,
               input  [7:0] data,
               output tx,
               output ready);

  reg  [7:0] bit_count;
  reg  [10:0] msg;
  reg  r_tx;
  reg  r_ready;

  
  initial  
  begin
    bit_count <= 0;
    msg <= 0;
    r_tx <= 0;
    r_ready <= 0;
  end
  
  always @(posedge clk)
      begin
        if (!msg && send) 
          begin
            msg <= {2'b11,data,1'b0};
          end
          
        if (msg) 
          begin
            r_tx <= msg[0];
            msg <= msg>>1;
          end
          
      end
  assign tx = r_tx;
  assign ready = !msg;
endmodule

