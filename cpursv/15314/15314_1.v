
module gen_capabilities(output [31:0] capabilities);

  wire memorycard;
  wire ac97;
  wire pfpu;
  wire tmu;
  wire ethernet;
  wire fmlmeter;
  wire videoin;
  wire midi;
  wire dmx;
  wire ir;
  wire usb;
  wire memtest;

  assign capabilities = {20'd0,memtest,usb,ir,dmx,midi,videoin,fmlmeter,ethernet,tmu,pfpu,ac97,memorycard};
  assign memorycard = 1'b0;
  assign ac97 = 1'b0;
  assign pfpu = 1'b0;
  assign tmu = 1'b0;
  assign ethernet = 1'b0;
  assign fmlmeter = 1'b0;
  assign videoin = 1'b0;
  assign midi = 1'b0;
  assign dmx = 1'b0;
  assign ir = 1'b0;
  assign usb = 1'b0;
  assign memtest = 1'b0;
endmodule

