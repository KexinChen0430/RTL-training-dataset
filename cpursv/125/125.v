
module ay_note_ram(addr,data);

  input  wire [6:0] addr;
  output wire [11:0] data;
  reg  [11:0] note_ram[0:127];

  
  initial  
  begin
    note_ram[0] <= 12'd03977;
    note_ram[1] <= 12'd03977;
    note_ram[21] <= 12'd03977;
    note_ram[22] <= 12'd03754;
    note_ram[23] <= 12'd03543;
    note_ram[127] <= 12'd09;
  end
  assign data = note_ram[addr];
endmodule

