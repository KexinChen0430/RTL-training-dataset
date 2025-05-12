module is designed for active-high reset use.
  (* ASYNC_REG = "TRUE" *) reg rst_in_meta  = 1'b0;
  (* ASYNC_REG = "TRUE" *) reg rst_in_sync1 = 1'b0;
  (* ASYNC_REG = "TRUE" *) reg rst_in_sync2 = 1'b0;
  (* ASYNC_REG = "TRUE" *) reg rst_in_sync3 = 1'b0;
                           reg rst_in_out   = 1'b0;
  always @(posedge clk_in, posedge rst_in) begin
    if (rst_in) begin
      rst_in_meta  <= 1'b1;
      rst_in_sync1 <= 1'b1;
      rst_in_sync2 <= 1'b1;
      rst_in_sync3 <= 1'b1;
      rst_in_out   <= 1'b1;
    end
    else begin
      rst_in_meta  <= 1'b0;
      rst_in_sync1 <= rst_in_meta;
      rst_in_sync2 <= rst_in_sync1;
      rst_in_sync3 <= rst_in_sync2;
      rst_in_out   <= rst_in_sync3;
    end
  end
  assign rst_out = rst_in_out;
endmodule