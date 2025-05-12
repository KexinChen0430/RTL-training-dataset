module pipeline_4_latch(
    clk, 
    dbusWire2, 
    DselectWire3, 
    bbusWire3, 
    lwSwFlag3, 
    dbusWire3, 
    DselectWire4, 
    bbusWire4, 
    lwSwFlag4 
);
pipeline_4_latch MEM_WB (
    .clk(clk),
    .dbusWire2(dbusWire2),
    .DselectWire3(DselectWire3),
    .bbusWire3(bbusWire3_5),
    .lwSwFlag3(lwSwFlag3),
    .dbusWire3(dbusWire3),
    .DselectWire4(DselectWire3_5),
    .bbusWire4(bbusWire4),
    .lwSwFlag4(lwSwFlag4)
);
assign mux3Out = (lwSwFlag4 == 2'b01)? bbusWire4:dbusWire3;
assign DselectWire4 = (lwSwFlag4 == 2'b10)? 32'h00000001: DselectWire3_5;
endmodule