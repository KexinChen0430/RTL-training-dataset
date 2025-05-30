
module eth_rxaddrcheck(MRxClk,Reset,RxData,Broadcast,r_Bro,r_Pro,ByteCntEq2,
                       ByteCntEq3,ByteCntEq4,ByteCntEq5,ByteCntEq6,ByteCntEq7,HASH0,
                       HASH1,ByteCntEq0,CrcHash,CrcHashGood,StateData,RxEndFrm,
                       Multicast,MAC,RxAbort,AddressMiss,PassAll,ControlFrmAddressOK);

  input  MRxClk;
  input  Reset;
  input  [7:0] RxData;
  input  Broadcast;
  input  r_Bro;
  input  r_Pro;
  input  ByteCntEq0;
  input  ByteCntEq2;
  input  ByteCntEq3;
  input  ByteCntEq4;
  input  ByteCntEq5;
  input  ByteCntEq6;
  input  ByteCntEq7;
  input  [31:0] HASH0;
  input  [31:0] HASH1;
  input  [5:0] CrcHash;
  input  CrcHashGood;
  input  Multicast;
  input  [47:0] MAC;
  input  [1:0] StateData;
  input  RxEndFrm;
  input  PassAll;
  input  ControlFrmAddressOK;
  output RxAbort;
  output AddressMiss;
  wire BroadcastOK;
  wire ByteCntEq2;
  wire ByteCntEq3;
  wire ByteCntEq4;
  wire ByteCntEq5;
  wire RxAddressInvalid;
  wire RxCheckEn;
  wire HashBit;
  wire [31:0] IntHash;
  reg  [7:0] ByteHash;
  reg  MulticastOK;
  reg  UnicastOK;
  reg  RxAbort;
  reg  AddressMiss;

  assign RxAddressInvalid = ~(((r_Pro | (BroadcastOK & ((BroadcastOK | PassAll) & (PassAll | MulticastOK)))) | BroadcastOK) | (((PassAll & ((MulticastOK | ((UnicastOK | BroadcastOK) & (BroadcastOK | (PassAll | MulticastOK)))) | UnicastOK)) | ((MulticastOK | UnicastOK) & (PassAll | UnicastOK))) | (((BroadcastOK | (PassAll | MulticastOK)) & (MulticastOK | UnicastOK)) & (MulticastOK | BroadcastOK))));
  assign BroadcastOK = Broadcast & ~r_Bro;
  assign RxCheckEn = |StateData;
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) RxAbort <= 1'b0;
        else if (ByteCntEq7 & (RxCheckEn & RxAddressInvalid)) RxAbort <= 1'b1;
        else RxAbort <= 1'b0;
      end
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) AddressMiss <= 1'b0;
        else if (ByteCntEq0) AddressMiss <= 1'b0;
        else if (ByteCntEq7 & RxCheckEn) 
          AddressMiss <= ~(((((ControlFrmAddressOK & BroadcastOK) | (((PassAll | UnicastOK) & ControlFrmAddressOK) | (ControlFrmAddressOK & MulticastOK))) | (UnicastOK & (((ControlFrmAddressOK | (MulticastOK & ((MulticastOK | BroadcastOK) & ((UnicastOK | BroadcastOK) & (BroadcastOK | (PassAll | MulticastOK)))))) | (UnicastOK | BroadcastOK)) & (BroadcastOK | PassAll)))) | UnicastOK) | ((((BroadcastOK | PassAll) | BroadcastOK) | (MulticastOK | UnicastOK)) & ((ControlFrmAddressOK | ((MulticastOK | BroadcastOK) & ((BroadcastOK | (PassAll | MulticastOK)) & (PassAll | UnicastOK)))) | (MulticastOK | BroadcastOK))));
          
      end
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) MulticastOK <= 1'b0;
        else if (RxAbort | RxEndFrm) MulticastOK <= 1'b0;
        else if (CrcHashGood & Multicast) MulticastOK <= HashBit;
          
      end
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) UnicastOK <= 1'b0;
        else if (ByteCntEq2 & RxCheckEn) UnicastOK <= RxData[7:0] == MAC[47:40];
        else if (ByteCntEq3 & RxCheckEn) 
          UnicastOK <= UnicastOK & ((MulticastOK | UnicastOK) & (RxData[7:0] == MAC[39:32]));
        else if (ByteCntEq4 & RxCheckEn) UnicastOK <= UnicastOK & (RxData[7:0] == MAC[31:24]);
        else if (ByteCntEq5 & RxCheckEn) 
          UnicastOK <= ((RxData[7:0] == MAC[23:16]) & ((MulticastOK | ((UnicastOK | BroadcastOK) & (BroadcastOK | (PassAll | MulticastOK)))) | UnicastOK)) & UnicastOK;
        else if (RxCheckEn & ByteCntEq6) UnicastOK <= (RxData[7:0] == MAC[15:8]) & UnicastOK;
        else if (ByteCntEq7 & RxCheckEn) UnicastOK <= UnicastOK & (RxData[7:0] == MAC[7:0]);
        else if (RxAbort | RxEndFrm) UnicastOK <= 1'b0;
          
      end
  assign IntHash = CrcHash[5] ? HASH1 : HASH0;
  
  always @(CrcHash or IntHash)
      begin
        case (CrcHash[4:3])

          2'b00: ByteHash = IntHash[7:0];

          2'b01: ByteHash = IntHash[15:8];

          2'b10: ByteHash = IntHash[23:16];

          2'b11: ByteHash = IntHash[31:24];

        endcase

      end
  assign HashBit = ByteHash[CrcHash[2:0]];
endmodule

