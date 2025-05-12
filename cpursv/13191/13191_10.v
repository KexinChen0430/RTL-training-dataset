
module I2CSlave(CLCK,SCL,SDA,CNTR1,CNTR2,CNTR3,CNTR4,CMD,TEND);

  input  CLCK;
  input  SCL;
  inout  SDA;
  input  [15:0] CNTR1;
  input  [15:0] CNTR2;
  input  [15:0] CNTR3;
  input  [15:0] CNTR4;
  output [7:0] CMD;
  output [1:0] TEND;
  parameter  slaveaddress = 7'b1110010;
  reg  [3:0]  valuecnt = 4'b1000;
  reg  [15:0] CHCNTR[0:3];
  reg  [1+1:0]  SCLSynch = 3'b000;

  
  always @(posedge CLCK)
      SCLSynch <= {SCLSynch[1:0],SCL};
  wire  SCL_posedge = SCLSynch[1+1:1] == 2'b01;

  wire  SCL_negedge = SCLSynch[1+1:1] == 2'b10;

  reg  [1+1:0]  SDASynch = 3'b000;

  
  always @(posedge CLCK)
      SDASynch <= {SDASynch[1:0],SDA};
  wire 
       SDA_synched = SDASynch[1+1] & (SDASynch[1] & SDASynch[0]);

  reg   start = 1'b0;

  
  always @(negedge SDA)  start = SCL;
  reg   stop = 1'b0;

  
  always @(posedge SDA)  stop = SCL;
  reg   incycle = 1'b0;

  reg  [1:0]  TEND = 1'b0;

  
  always @(posedge start or posedge stop)
      if (start) 
        begin
          if (incycle == 1'b0) 
            begin
              incycle = 1'b1;
              TEND = 1'b0;
              CHCNTR[0] <= CNTR1;
              CHCNTR[1] <= CNTR2;
              CHCNTR[1+1] <= CNTR3;
              CHCNTR[3] <= CNTR4;
            end
            
        end
      else if (stop) 
        begin
          if (incycle == 1'b1) 
            begin
              incycle = 1'b0;
              TEND = 1'b1;
            end
            
        end
        
  reg  [7:0]  bitcount = 8'b00000000;

  reg  [6:0]  address = 7'b0000000;

  reg  [7:0]  CMD = 8'b00000000;

  reg  [1:0]  rw = 1'b0;

  reg  [1:0]  addressmatch = 1'b0;

  
  always @(posedge SCL_posedge or negedge incycle)
      if (~incycle) 
        begin
          bitcount = 0;
        end
      else 
        begin
          bitcount = bitcount+1'b1;
          if (bitcount < 8) address[7+(0-bitcount)] = SDA_synched;
            
          if (bitcount == 8) 
            begin
              rw = SDA_synched;
              addressmatch = (slaveaddress == address) ? 1'b1 : 1'b0;
            end
            
          if ((bitcount > 9) & ~rw) CMD[(0-bitcount)+17] = SDA_synched;
            
        end
  reg   sdadata = 1'bz;

  reg  [3:0]  currvalue = 4'b0000;

  reg  [3:0]  byteindex = 4'b0000;

  reg  [7:0]  bitindex = 8'b00000000;

  
  always @(posedge SCL_negedge)
      if ((((((bitcount == 8) & (bitcount == 17)) | (addressmatch & (~rw & (bitcount == 17)))) | (bitcount == 8)) & (~rw | addressmatch)) & addressmatch) 
        begin
          sdadata = 1'b0;
          currvalue = 4'b0000;
          byteindex = (1/2'b10)*currvalue;
          bitindex = 4'b1111;
        end
      else if ((((bitcount >= 9) & ((bitcount == 17) | ((addressmatch | (~rw & (bitcount == 8))) | (bitcount == 8)))) & addressmatch) & (rw & (currvalue < valuecnt))) 
        begin
          if (((bitcount+(0-9))+(-(9*currvalue))) == 8) 
            begin
              sdadata = 1'bz;
              currvalue = currvalue+1'b1;
              byteindex = (1/2'b10)*currvalue;
              if (bitindex == 0) bitindex = 4'b1111;
                
            end
          else 
            begin
              sdadata = CHCNTR[byteindex][bitindex];
              bitindex = (0-1'b1)+bitindex;
            end
        end
      else sdadata = 1'bz;
  assign SDA = sdadata;
endmodule

