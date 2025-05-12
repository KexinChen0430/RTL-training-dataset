module token_in(data, pid, addr, endp, in, err);
  (* src = "Token.v:14" *)
  output [6:0] addr;
  (* src = "Token.v:21" *)
  (* unused_bits = "0 1 2 3 4" *)
  wire [4:0] crc1;
  (* src = "Token.v:12" *)
  input [23:0] data;
  (* src = "Token.v:15" *)
  output [3:0] endp;
  (* src = "Token.v:16" *)
  output err;
  (* src = "Token.v:13" *)
  output in;
  (* src = "Token.v:18" *)
  output [7:0] pid;
  assign addr = data[15:9];
  assign crc1 = data[4:0];
  assign endp = data[8:5];
  assign pid = data[23:16];
endmodule