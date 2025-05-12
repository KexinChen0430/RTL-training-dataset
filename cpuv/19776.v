module CRC5_D11(nextCRC5_D11, Data, crc); 
  (* src = "CRC5_D5.v:38" *) 
  wire _00_; 
  (* src = "CRC5_D5.v:38" *) 
  wire _01_; 
  (* src = "CRC5_D5.v:26" *)
  input [10:0] Data; 
  (* src = "CRC5_D5.v:29" *)
  wire [4:0] c; 
  (* src = "CRC5_D5.v:27" *)
  input [4:0] crc; 
  (* src = "CRC5_D5.v:28" *)
  wire [10:0] d; 
  (* src = "CRC5_D5.v:30" *)
  wire [4:0] newcrc; 
  (* src = "CRC5_D5.v:25" *)
  output [4:0] nextCRC5_D11; 
  assign _00_ = Data[10] ^ Data[9];
  assign _01_ = _00_ ^ Data[6];
  assign nextCRC5_D11[0] = _06_ ^ crc[4]; 
  assign c = crc; 
  assign d = Data; 
  assign newcrc = nextCRC5_D11; 
endmodule 