
module arriaiigz_lvds_rx_deser(clk,datain,devclrn,devpor,dataout);

  parameter  channel_width = 10;
  input  clk;
  input  datain;
  input  devclrn;
  input  devpor;
  output [channel_width-1:0] dataout;
  reg  [channel_width-1:0] dataout_tmp;
  reg  clk_last_value;
  integer i;

  
  specify
    ( posedge clk => (dataout +: dataout_tmp) ) = (0,0);
  endspecify

  
  initial  
  begin
    clk_last_value = 0;
    dataout_tmp = 'b0;
  end
  
  always @(clk or devclrn or devpor)
      begin
        if ((devclrn === 1'b0) || (devpor === 1'b0)) 
          begin
            dataout_tmp <= 'b0;
          end
        else if ((clk === 1'b1) && (clk_last_value === 1'b0)) 
          begin
            for (i = channel_width-1; i > 0; i = i+(0-1))
                dataout_tmp[i] <= dataout_tmp[i+(0-1)];
            dataout_tmp[0] <= datain;
          end
          
        clk_last_value <= clk;
      end
  assign dataout = dataout_tmp;
endmodule

