
module stratixiv_lvds_rx_deser(clk,datain,devclrn,devpor,dataout);

  parameter  channel_width = 10;
  input  clk;
  input  datain;
  input  devclrn;
  input  devpor;
  output [(-1)+channel_width:0] dataout;
  reg  [(-1)+channel_width:0] dataout_tmp;
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
        else if ((clk_last_value === 1'b0) && (clk === 1'b1)) 
          begin
            for (i = (-1)+channel_width; i > 0; i = i+(-1))
                dataout_tmp[i] <= dataout_tmp[i+(-1)];
            dataout_tmp[0] <= datain;
          end
          
        clk_last_value <= clk;
      end
  assign dataout = dataout_tmp;
endmodule

