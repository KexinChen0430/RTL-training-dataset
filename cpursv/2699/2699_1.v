
module C_FRAG(TBS,TAB,TSL,TA1,TA2,TB1,TB2,BAB,BSL,BA1,BA2,BB1,BB2,TZ,CZ);

  input  wire TBS;
  input  wire TAB;
  input  wire TSL;
  input  wire TA1;
  input  wire TA2;
  input  wire TB1;
  input  wire TB2;
  input  wire BAB;
  input  wire BSL;
  input  wire BA1;
  input  wire BA2;
  input  wire BB1;
  input  wire BB2;
  output wire TZ;
  output wire CZ;
  parameter  TAS1 = 1'b0;
  parameter  TAS2 = 1'b0;
  parameter  TBS1 = 1'b0;
  parameter  TBS2 = 1'b0;
  parameter  BAS1 = 1'b0;
  parameter  BAS2 = 1'b0;
  parameter  BBS1 = 1'b0;
  parameter  BBS2 = 1'b0;
  wire  TAP1 = TAS1 ? ~TA1 : TA1;
  wire  TAP2 = TAS2 ? ~TA2 : TA2;
  wire  TBP1 = TBS1 ? ~TB1 : TB1;
  wire  TBP2 = TBS2 ? ~TB2 : TB2;
  wire  BAP1 = BAS1 ? ~BA1 : BA1;
  wire  BAP2 = BAS2 ? ~BA2 : BA2;
  wire  BBP1 = BBS1 ? ~BB1 : BB1;
  wire  BBP2 = BBS2 ? ~BB2 : BB2;
  wire  TAI = TSL ? TAP2 : TAP1;
  wire  TBI = TSL ? TBP2 : TBP1;
  wire  BAI = BSL ? BAP2 : BAP1;
  wire  BBI = BSL ? BBP2 : BBP1;
  wire  TZI = TAB ? TBI : TAI;
  wire  BZI = BAB ? BBI : BAI;
  wire  CZI = TBS ? BZI : TZI;

  assign TZ = TZI;
  assign CZ = CZI;
  
  specify
    (TBS => CZ) = (0,0);
    (TAB => CZ) = (0,0);
    (TSL => CZ) = (0,0);
    (TA1 => CZ) = (0,0);
    (TA2 => CZ) = (0,0);
    (TB1 => CZ) = (0,0);
    (TB2 => CZ) = (0,0);
    (BAB => CZ) = (0,0);
    (BSL => CZ) = (0,0);
    (BA1 => CZ) = (0,0);
    (BA2 => CZ) = (0,0);
    (BB1 => CZ) = (0,0);
    (BB2 => CZ) = (0,0);
    (TAB => TZ) = (0,0);
    (TSL => TZ) = (0,0);
    (TA1 => TZ) = (0,0);
    (TA2 => TZ) = (0,0);
    (TB1 => TZ) = (0,0);
    (TB2 => TZ) = (0,0);
  endspecify

endmodule

