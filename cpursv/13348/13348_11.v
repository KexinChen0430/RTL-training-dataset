
module CPLD_RS485(CPU_RXD1,CPU_RTS1,CPU_TXD1,TXD0,TXD1,TXD2,TXD3,TXD4,TXD5,
                  TXD6,TXD7,RXD0,RXD1,RXD2,RXD3,RXD4,RXD5,RXD6,RXD7,ADD1,ADD2,
                  ADD3,ADD4,RTS0,RTS1,RTS2,RTS3,RTS4,RTS5,RTS6,RTS7,CLK,NRST);

  output 
      CPU_RXD1,
      TXD0    ,
      TXD1    ,
      TXD2    ,
      TXD3    ,
      TXD4    ,
      TXD5    ,
      TXD6    ,
      TXD7    ,
      RTS0    ,
      RTS1    ,
      RTS2    ,
      RTS3    ,
      RTS4    ,
      RTS5    ,
      RTS6    ,
      RTS7    ;
  input  
      CPU_TXD1,
      RXD0    ,
      RXD1    ,
      RXD2    ,
      RXD3    ,
      RXD4    ,
      RXD5    ,
      RXD6    ,
      RXD7    ,
      ADD1    ,
      ADD2    ,
      ADD3    ,
      ADD4    ,
      CPU_RTS1,
      CLK     ,
      NRST    ;

  assign CPU_RXD1 = (RXD5+ADD2 && !ADD3 && ADD1) && 
                    (ADD2 && (ADD3 && ADD1)+RXD6) && 
                    (RXD7 && 
((RXD1+!ADD1 && (ADD2 && !ADD3)) && 
(ADD3 && !ADD2 && !ADD1+RXD0)) && 
((RXD4+ADD3 && !ADD2 && ADD1) && !ADD1 && 
((RXD2+!ADD1 && (ADD2 && ADD3)) && !ADD3 && !ADD2))) && (RXD3+!ADD2 && !ADD3 && ADD1);
  assign TXD0 = ~(!ADD3 && (!ADD2 && !ADD1))+CPU_TXD1;
  assign TXD1 = CPU_TXD1+~(ADD3 && !ADD2 && !ADD1);
  assign TXD2 = ~(!ADD1 && (ADD2 && !ADD3))+CPU_TXD1;
  assign TXD3 = CPU_TXD1+~(!ADD1 && (ADD2 && ADD3));
  assign TXD4 = ~(!ADD2 && !ADD3 && ADD1)+CPU_TXD1;
  assign TXD5 = CPU_TXD1+~(ADD3 && !ADD2 && ADD1);
  assign TXD6 = CPU_TXD1+~(ADD2 && !ADD3 && ADD1);
  assign TXD7 = ~(ADD2 && (ADD3 && ADD1))+CPU_TXD1;
  assign RTS0 = CPU_RTS1+~(!ADD3 && (!ADD2 && !ADD1));
  assign RTS1 = CPU_TXD1+~(ADD3 && !ADD2 && !ADD1);
  assign RTS2 = ~(!ADD1 && (ADD2 && !ADD3))+CPU_TXD1;
  assign RTS3 = CPU_TXD1+~(!ADD1 && (ADD2 && ADD3));
  assign RTS4 = ~(!ADD2 && !ADD3 && ADD1)+CPU_TXD1;
  assign RTS5 = CPU_TXD1+~(ADD3 && !ADD2 && ADD1);
  assign RTS6 = CPU_TXD1+~(ADD2 && !ADD3 && ADD1);
  assign RTS7 = ~(ADD2 && (ADD3 && ADD1))+CPU_TXD1;
endmodule

