
module bus_to_ip  #(parameter 
       BASEADDR  = 0,
       HIGHADDR  = 0,
       ABUSWIDTH = 16,
       DBUSWIDTH = 8)
  (input  wire BUS_RD,
   input  wire BUS_WR,
   input  wire [(0-1)+ABUSWIDTH:0] BUS_ADD,
   inout  wire [(0-1)+DBUSWIDTH:0] BUS_DATA,
   output wire IP_RD,
   output wire IP_WR,
   output wire [(0-1)+ABUSWIDTH:0] IP_ADD,
   output wire [(0-1)+DBUSWIDTH:0] IP_DATA_IN,
   input  wire [(0-1)+DBUSWIDTH:0] IP_DATA_OUT);

  wire CS;

  assign CS = (BUS_ADD <= HIGHADDR) && (BUS_ADD >= BASEADDR);
  assign IP_ADD = CS ? (BUS_ADD+(0-BASEADDR)) : {ABUSWIDTH{1'b0}};
  assign IP_RD = CS ? BUS_RD : 1'b0;
  assign IP_WR = CS ? BUS_WR : 1'b0;
  assign IP_DATA_IN = BUS_DATA;
  assign BUS_DATA = (CS && BUS_WR) ? {DBUSWIDTH{1'bz}} : 
                    CS ? IP_DATA_OUT : {DBUSWIDTH{1'bz}};
endmodule

