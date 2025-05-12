
module sbus_to_ip  #(parameter 
       BASEADDR  = 0,
       HIGHADDR  = 0,
       ABUSWIDTH = 16,
       DBUSWIDTH = 8)
  (input  wire BUS_CLK,
   input  wire BUS_RD,
   input  wire BUS_WR,
   input  wire [(0-1)+ABUSWIDTH:0] BUS_ADD,
   input  wire [(0-1)+DBUSWIDTH:0] BUS_DATA_IN,
   output wire [(0-1)+DBUSWIDTH:0] BUS_DATA_OUT,
   output wire IP_RD,
   output wire IP_WR,
   output wire [(0-1)+ABUSWIDTH:0] IP_ADD,
   output wire [(0-1)+DBUSWIDTH:0] IP_DATA_IN,
   input  wire [(0-1)+DBUSWIDTH:0] IP_DATA_OUT);

  wire CS;

  assign CS = (BUS_ADD <= HIGHADDR) && (BUS_ADD >= BASEADDR);
  assign IP_ADD = CS ? (BUS_ADD-BASEADDR) : {ABUSWIDTH{1'b0}};
  assign IP_RD = CS ? BUS_RD : 1'b0;
  assign IP_WR = CS ? BUS_WR : 1'b0;
  assign IP_DATA_IN = BUS_DATA_IN;
  reg  CS_PREV;

  
  always @(posedge BUS_CLK)
      begin
        CS_PREV <= CS;
      end
  assign BUS_DATA_OUT = CS_PREV ? IP_DATA_OUT : {DBUSWIDTH{1'b0}};
endmodule

