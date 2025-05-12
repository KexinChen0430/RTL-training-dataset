module DNegflipFlop(dbus, abus, Dselect, Bselect, Aselect, bbus, clk);
  input [63:0] dbus;
  input Dselect;
  input Bselect;
  input Aselect;
  input clk;
  output [63:0] abus;
  output [63:0] bbus;
  wire wireclk;
  reg [63:0] data;
  assign wireclk = clk & Dselect;
  initial begin
  data = 64'h0000000000000000;
  end
  always @(negedge clk) begin
    if(Dselect) begin
      data = dbus;
    end
  end
  assign abus = Aselect? data : 64'hzzzzzzzzzzzzzzzz;
  assign bbus = Bselect? data : 64'hzzzzzzzzzzzzzzzz;
endmodule