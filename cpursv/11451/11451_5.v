
module EHRU_8(CLK,read_0,write_0,EN_write_0,read_1,write_1,EN_write_1,
              read_2,write_2,EN_write_2,read_3,write_3,EN_write_3,read_4,
              write_4,EN_write_4,read_5,write_5,EN_write_5,read_6,write_6,
              EN_write_6,read_7,write_7,EN_write_7);

  parameter  DATA_SZ = 1;
  parameter  RESET_VAL = 0;
  input  CLK;
  output [DATA_SZ+(-1):0] read_0;
  input  [DATA_SZ+(-1):0] write_0;
  input  EN_write_0;
  reg  [DATA_SZ+(-1):0] r;
  wire [DATA_SZ+(-1):0] wire_0;

  assign wire_0 = r;
  assign wire_1 = EN_write_0 ? write_0 : wire_0;
  assign read_0 = wire_0;
  
  always @(posedge CLK)  begin
    r <= wire_8;
  end
endmodule

