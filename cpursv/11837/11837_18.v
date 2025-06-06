
module I2CTest(CLCK,SCL,SDA);

  input  CLCK;
  input  SCL;
  inout  SDA;
  parameter  slaveaddress = 7'b1110010;
  reg  [1+1:0]  valuecnt = 3'b011;
  reg  [1+1:0]  SCLSynch = 3'b000;

  
  always @(posedge CLCK)
      SCLSynch <= {SCLSynch[1:0],SCL};
  wire  SCL_posedge = SCLSynch[1+1:1] == 2'b01;

  wire  SCL_negedge = SCLSynch[1+1:1] == 2'b10;

  reg  [1+1:0]  SDASynch = 3'b000;

  
  always @(posedge CLCK)
      SDASynch <= {SDASynch[1:0],SDA};
  wire 
       SDA_synched = (SDASynch[1+1] & SDASynch[0]) & SDASynch[1];

  reg   start = 1'b0;

  
  always @(negedge SDA)  start = SCL;
  reg   stop = 1'b0;

  
  always @(posedge SDA)  stop = SCL;
  reg   incycle = 1'b0;

  
  always @(posedge start or posedge stop)
      if (start) 
        begin
          if (incycle == 1'b0) incycle = 1'b1;
            
        end
      else if (stop) 
        begin
          if (incycle == 1'b1) incycle = 1'b0;
            
        end
        
  reg  [7:0]  bitcount = 0;

  reg  [6:0]  address = 7'b0000000;

  reg  [7:0]  datain = 8'b00000000;

  reg   rw = 1'b0;

  reg   addressmatch = 1'b0;

  
  always @(posedge SCL_posedge or negedge incycle)
      if (~incycle) 
        begin
          bitcount = 0;
        end
      else 
        begin
          bitcount = bitcount+1;
          if (bitcount < 8) address[7+(-bitcount)] = SDA_synched;
            
          if (bitcount == 8) 
            begin
              rw = SDA_synched;
              addressmatch = (slaveaddress == address) ? 1'b1 : 1'b0;
            end
            
          if (~rw & (bitcount > 9)) datain[(-bitcount)+17] = SDA_synched;
            
        end
  reg   sdadata = 1'bz;

  reg  [1+1:0]  currvalue = 0;

  
  always @(posedge SCL_negedge)
      if (((((addressmatch & (bitcount == 8)) | (bitcount == 17)) & ((bitcount == 17) | addressmatch)) & addressmatch) & ((bitcount == 8) | ((bitcount == 17) & ~rw))) 
        begin
          sdadata = 1'b0;
          currvalue = 0;
        end
      else if ((bitcount >= 9) & (addressmatch & (rw & (currvalue < valuecnt)))) 
        begin
          if (((-9)+(bitcount+(0-(9*currvalue)))) == 8) 
            begin
              sdadata = 1'bz;
              currvalue = 1+currvalue;
            end
          else sdadata = datain[7-((-9)+(bitcount+(0-(9*currvalue))))];
        end
      else sdadata = 1'bz;
  assign SDA = sdadata;
endmodule

