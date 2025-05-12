module pipeline_3_latch(clk, dbusWire1, DselectWire2, dbusWire2, DselectWire3);
  pipeline_3_latch EX_MEME (.clk(clk),.dbusWire1(dbusWire1),.DselectWire2(DselectWire2),.dbusWire2(dbusWire2),.DselectWire3(DselectWire3));
  assign dbus = dbusWire2;
endmodule