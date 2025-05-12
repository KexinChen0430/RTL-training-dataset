
module usb_sync_detect(input  rst_n,
                       input  clk,
                       input  clken,
                       input  j,
                       input  se0,
                       output sync);

  reg  [6:0] data;

  assign sync = !se0 && ((data == 7'b0101010) && !j);
  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            data <= 1'd0;
          end
        else if (clken) 
          begin
            data <= {data[5:0],se0 || j};
          end
          
      end
endmodule

