
module weight(CLK,RST,ED,START,DReal,DImag,DOReal,DOImag,RDY);

  parameter  total_bits = 32;
  input  CLK;
  input  RST;
  input  ED;
  input  START;
  output reg RDY;
  input  [total_bits+(-1):0] DReal;
  input  [total_bits+(-1):0] DImag;
  output [total_bits+(-1):0] DOReal;
  output [total_bits+(-1):0] DOImag;
  reg  [4:0] ADDR;
  reg  [1:0] state;
  reg  signed  [31:0] re[0:15];
  reg  signed  [31:0] im[0:15];

  
  initial  
  begin
    re[0] = 32'h00010000;
    re[1] = 32'h0000FB15;
    im[0] = 32'h00000000;
    im[1] = 32'hFFFFCE0F;
  end
  
  always @(posedge CLK)
      begin
        if (RST) 
          begin
            ADDR <= 18;
            state <= 0;
            RDY <= 0;
          end
        else if (START) 
          begin
            if (state == 0) state <= 1;
            else if (state == 1) 
              begin
                state <= 2;
                ADDR <= 0;
              end
            else if (state == 2) state <= 1;
              
            RDY <= 0;
          end
        else if (ED) 
          begin
            RDY <= 0;
            if ((state == 2) && (ADDR != 18)) ADDR <= 1+ADDR;
              
          end
          
        if (ADDR == 1) RDY <= 1;
          
      end
  reg  signed  [total_bits+(-1):0] drd,did;

  reg  signed  [total_bits+(-1):0] wrd,wid;

  wire signed  [total_bits<<1+(-1):0] drri,drii,diri,diii;

  reg  signed  [total_bits:0] drr,dri,dir,dii,dwr,dwi;

  assign drri = wrd*drd;
  assign diri = did*wrd;
  assign drii = drd*wid;
  assign diii = wid*did;
  
  always @(posedge CLK)
      begin
        if ((state == 2) && ED && (ADDR != 18)) 
          begin
            drd <= DReal;
            did <= DImag;
            wrd <= re[ADDR];
            wid <= im[ADDR];
            drr <= drri[47:15];
            dri <= drii[47:15];
            dir <= diri[47:15];
            dii <= diii[47:15];
            dwr <= (-dii)+drr;
            dwi <= dri+dir;
          end
          
      end
  assign DOReal = dwr[total_bits:1];
  assign DOImag = dwi[total_bits:1];
endmodule

