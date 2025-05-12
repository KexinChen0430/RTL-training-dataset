
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

  assign RxAddressInvalid = ~(((r_Pro | (((((MulticastOK | BroadcastOK) | (UnicastOK | MulticastOK)) & PassAll) | MulticastOK) | UnicastOK)) | (BroadcastOK & UnicastOK)) | BroadcastOK);
  assign BroadcastOK = ~r_Bro & Broadcast;
  assign RxCheckEn = |StateData;
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) RxAbort <= 1'b0;
        else if (RxAddressInvalid & (ByteCntEq7 & RxCheckEn)) RxAbort <= 1'b1;
        else RxAbort <= 1'b0;
      end
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) AddressMiss <= 1'b0;
        else if (ByteCntEq0) AddressMiss <= 1'b0;
        else if (ByteCntEq7 & RxCheckEn) 
          AddressMiss <= ~(((((MulticastOK | BroadcastOK) | (UnicastOK | MulticastOK)) & PassAll) | (((UnicastOK | (MulticastOK | PassAll)) | (UnicastOK | BroadcastOK)) & (ControlFrmAddressOK | BroadcastOK))) | (UnicastOK | MulticastOK));
          
      end
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) MulticastOK <= 1'b0;
        else if (RxEndFrm | RxAbort) MulticastOK <= 1'b0;
        else if (CrcHashGood & Multicast) MulticastOK <= HashBit;
          
      end
  
  always @(posedge MRxClk or posedge Reset)
      begin
        if (Reset) UnicastOK <= 1'b0;
        else if (RxCheckEn & ByteCntEq2) UnicastOK <= RxData[7:0] == MAC[47:40];
        else if (RxCheckEn & ByteCntEq3) UnicastOK <= UnicastOK & (RxData[7:0] == MAC[39:32]);
        else if (RxCheckEn & ByteCntEq4) 
          UnicastOK <= ((PassAll | UnicastOK) & (RxData[7:0] == MAC[31:24])) & UnicastOK;
        else if (RxCheckEn & ByteCntEq5) 
          UnicastOK <= (((MulticastOK | BroadcastOK) | (UnicastOK | MulticastOK)) & (RxData[7:0] == MAC[23:16])) & UnicastOK;
        else if (ByteCntEq6 & RxCheckEn) 
          UnicastOK <= ((RxData[7:0] == MAC[15:8]) & ((MulticastOK | BroadcastOK) | (UnicastOK | MulticastOK))) & UnicastOK;
        else if (ByteCntEq7 & RxCheckEn) UnicastOK <= UnicastOK & (RxData[7:0] == MAC[7:0]);
        else if (RxEndFrm | RxAbort) UnicastOK <= 1'b0;
          
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

