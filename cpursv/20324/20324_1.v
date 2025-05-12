
module DQSBUFM(input  DQSI,
               input  READ1,
               input  READ0,
               input  READCLKSEL2,
               input  READCLKSEL1,
               input  READCLKSEL0,
               input  DDRDEL,
               input  ECLK,
               input  SCLK,
               input  DYNDELAY7,
               input  DYNDELAY6,
               input  DYNDELAY5,
               input  DYNDELAY4,
               input  DYNDELAY3,
               input  DYNDELAY2,
               input  DYNDELAY1,
               input  DYNDELAY0,
               input  RST,
               input  RDLOADN,
               input  RDMOVE,
               input  RDDIRECTION,
               input  WRLOADN,
               input  WRMOVE,
               input  WRDIRECTION,
               input  PAUSE,
               output DQSR90,
               output DQSW,
               output DQSW270,
               output RDPNTR2,
               output RDPNTR1,
               output RDPNTR0,
               output WRPNTR2,
               output WRPNTR1,
               output WRPNTR0,
               output DATAVALID,
               output BURSTDET,
               output RDCFLAG,
               output WRCFLAG);

  parameter  DQS_LI_DEL_ADJ = FACTORYONLY;
  parameter  DQS_LI_DEL_VAL = 0;
  parameter  DQS_LO_DEL_ADJ = FACTORYONLY;
  parameter  DQS_LO_DEL_VAL = 0;
  parameter  GSR = ENABLED;


endmodule

