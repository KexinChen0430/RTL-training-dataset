
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
  reg  [2:0]  SCLSynch = 3'b000;

  
  always @(posedge CLCK)
      SCLSynch <= {SCLSynch[1:0],SCL};
  wire  SCL_posedge = SCLSynch[2:1] == 2'b01;

  wire  SCL_negedge = SCLSynch[2:1] == 2'b10;

  reg  [2:0]  SDASynch = 3'b000;

  
  always @(posedge CLCK)
      SDASynch <= {SDASynch[1:0],SDA};
  wire 
       SDA_synched = SDASynch[1] & (SDASynch[0] & SDASynch[2]);

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
              CHCNTR[2] <= CNTR3;
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
          bitcount = 1'b1+bitcount;
          if (bitcount < 8) address[(-bitcount)+7] = SDA_synched;
            
          if (bitcount == 8) 
            begin
              rw = SDA_synched;
              addressmatch = (slaveaddress == address) ? 1'b1 : 1'b0;
            end
            
          if ((bitcount > 9) & ~rw) CMD[17-bitcount] = SDA_synched;
            
        end
  reg   sdadata = 1'bz;

  reg  [3:0]  currvalue = 4'b0000;

  reg  [3:0]  byteindex = 4'b0000;

  reg  [7:0]  bitindex = 8'b00000000;

  
  always @(posedge SCL_negedge)
      if (addressmatch & (((((bitcount == 17) & ~rw) | addressmatch) & ((((bitcount == 17) & ~rw) | (bitcount == 8)) | (bitcount == 17))) & (((~rw | ((bitcount == 8) & (bitcount == 17))) | (((bitcount == 17) & ~rw) | ((bitcount == 8) & (bitcount == 17)))) | (bitcount == 8)))) 
        begin
          sdadata = 1'b0;
          currvalue = 4'b0000;
          byteindex = currvalue/2'b10;
          bitindex = 4'b1111;
        end
      else if ((rw & (bitcount >= 9)) & (((currvalue < valuecnt) & ((bitcount == 8) | addressmatch)) & addressmatch)) 
        begin
          if ((((-(currvalue*9))+bitcount)+(-9)) == 8) 
            begin
              sdadata = 1'bz;
              currvalue = currvalue+1'b1;
              byteindex = currvalue/2'b10;
              if (bitindex == 0) bitindex = 4'b1111;
                
            end
          else 
            begin
              sdadata = CHCNTR[byteindex][bitindex];
              bitindex = bitindex-1'b1;
            end
        end
      else sdadata = 1'bz;
  assign SDA = sdadata;
endmodule

