
module spi_interface();

  parameter  N = 8;
  reg  [N-1:0] dout;
  reg  [N-1:0] din_temp;
  reg  [N-1:0] dout_temp;

  assign miso = din_temp[N-1];
  
  always @(posedge ssbar)
      begin
        dout <= dout_temp;
      end
  
  always @(negedge ssbar)
      begin
        din_temp <= din;
      end
  
  always @(posedge sclk)
      begin
        if (ssbar == 0) dout_temp <= {dout_temp[N-1<<1:0],mosi};
          
      end
  
  always @(negedge sclk)
      begin
        if (ssbar == 0) din_temp <= {din_temp[N-1<<1:0],1'b0};
          
      end
endmodule

