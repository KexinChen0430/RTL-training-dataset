module DNegflipFlop(dbus, abus, Dselect, Bselect, Aselect, bbus, clk);
  input [31:0] dbus;
  input Dselect;
  input Bselect;
  input Aselect;
  input clk;
  output [31:0] abus;
  output [31:0] bbus;
  wire wireclk;
  reg [31:0] data;
  assign wireclk = clk & Dselect;
  initial begin
  data = 32'h00000000;
  end
  always @(negedge wireclk) begin
    if(Dselect) begin
      data = dbus;
    end
  end
  assign abus = Aselect? data : 32'hzzzzzzzz;
  assign bbus = Bselect? data : 32'hzzzzzzzz;
endmodule