
module tv80_reg(DOBH,DOAL,DOCL,DOBL,DOCH,DOAH,BC,DE,HL,AddrC,AddrA,AddrB,DIH,
                DIL,clk,CEN,WEH,WEL);

  input  [2:0] AddrC;
  output [7:0] DOBH;
  input  [2:0] AddrA;
  input  [2:0] AddrB;
  input  [7:0] DIH;
  output [7:0] DOAL;
  output [7:0] DOCL;
  input  [7:0] DIL;
  output [7:0] DOBL;
  output [7:0] DOCH;
  output [7:0] DOAH;
  input  clk,CEN,WEH,WEL;
  output [15:0] BC;
  output [15:0] DE;
  output [15:0] HL;
  reg  [7:0] RegsH[0:7];
  reg  [7:0] RegsL[0:7];

  
  always @(posedge clk)
      begin
        if (CEN) 
          begin
            if (WEH) RegsH[AddrA] <= DIH;
              
            if (WEL) RegsL[AddrA] <= DIL;
              
          end
          
      end
  assign DOAH = RegsH[AddrA];
  assign DOAL = RegsL[AddrA];
  assign DOBH = RegsH[AddrB];
  assign DOBL = RegsL[AddrB];
  assign DOCH = RegsH[AddrC];
  assign DOCL = RegsL[AddrC];
  wire [7:0]  H = RegsH[2];

  wire [7:0]  L = RegsL[2];

  assign BC = {RegsH[0],RegsL[0]};
  assign DE = {RegsH[1],RegsL[1]};
  assign HL = {RegsH[2],RegsL[2]};
endmodule

