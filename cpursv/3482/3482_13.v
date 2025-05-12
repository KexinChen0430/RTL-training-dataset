
module bus_to_ip  #(parameter 
       BASEADDR  = 0,
       HIGHADDR  = 0,
       ABUSWIDTH = 16,
       DBUSWIDTH = 8)
  (input  wire BUS_RD,
   input  wire BUS_WR,
   input  wire [ABUSWIDTH-1:0] BUS_ADD,
   inout  wire [DBUSWIDTH-1:0] BUS_DATA,
   output wire IP_RD,
   output wire IP_WR,
   output wire [ABUSWIDTH-1:0] IP_ADD,
   output wire [DBUSWIDTH-1:0] IP_DATA_IN,
   input  wire [DBUSWIDTH-1:0] IP_DATA_OUT);

  wire CS;

  assign CS = (BUS_ADD >= BASEADDR) && (BUS_ADD <= HIGHADDR);
  assign IP_ADD = CS ? ((0-BASEADDR)+BUS_ADD) : {ABUSWIDTH{1'b0}};
  assign IP_RD = CS ? BUS_RD : 1'b0;
  assign IP_WR = CS ? BUS_WR : 1'b0;
  assign IP_DATA_IN = BUS_DATA;
  assign BUS_DATA = (BUS_WR && CS) ? {DBUSWIDTH{1'bz}} : 
                    CS ? IP_DATA_OUT : {DBUSWIDTH{1'bz}};
endmodule

