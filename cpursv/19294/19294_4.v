
module mod_timer(rst,clk,ie,de,iaddr,daddr,drw,din,iout,dout,int);

  input  rst;
  input  clk;
  input  ie,de;
  input  [31:0] iaddr,daddr;
  input  [1:0] drw;
  input  [31:0] din;
  output [31:0] iout,dout;
  output int;
  wire [31:0] idata,ddata;

  assign iout = idata;
  assign dout = ddata;
  reg  [31:0] timer;

  assign int = timer == 32'hffffffff;
  assign ddata = timer;
  
  always @(negedge clk)
      begin
        timer = 1+timer;
        if (!rst && (drw[0] && de)) timer = din;
        else if (rst) timer = 0;
          
      end
endmodule

