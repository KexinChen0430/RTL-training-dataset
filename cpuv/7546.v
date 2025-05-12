module implements a task that sends data over the I2C bus
  */
  output reg SDA,
  output reg SCL,
  output reg dbg=0
  );
  reg [7:0] dataSent = 8'bz0zzz0zz, addressSent=8'bzzz0000z; 
  integer i=0;
  task sendData;
    input [7:0] addressSent,dataSent;
    begin
      #5;
      SDA=1;SCL=1;
      #1;
      SDA=0;
      #1;
      SCL=0;
      for(i=7;i>=0;i--) begin
        SCL=0;SDA=addressSent[i];#1;SCL=1;#1;
      end
      SDA=1'bz;
      SCL=0;
      #1;
      SCL=1;#1;
      for(i=7;i>=0;i--) begin
        SCL=0;SDA=dataSent[i];#1;SCL=1;#1;
        end
      SCL=0;#1;SCL=1;#1;SCL=0;#1;
      SDA=0;#1;SCL=1;#2;SDA=1'bz;
      #10;
    end
  endtask
endmodule