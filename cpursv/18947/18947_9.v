
module mod_gpio(rst,clk,ie,de,iaddr,daddr,drw,din,iout,dout,gpio);

  input  rst;
  input  clk;
  input  ie,de;
  input  [31:0] iaddr,daddr;
  input  [1:0] drw;
  input  [31:0] din;
  output [31:0] iout,dout;
  inout  [15:0] gpio;
  wire [31:0] idata,ddata;

  assign iout = idata;
  assign dout = ddata;
  reg  [15:0]  direction = 16'h0000;

  reg  [7:0] gpio_a,gpio_b;

  assign idata = 32'h00000000;
  assign ddata = (daddr == 32'h00000000) ? {16'h0000,direction} : 
                 (daddr == 32'h00000004) ? {24'h000000,gpio[7:0]} : 
                 (daddr == 32'h00000008) ? {24'h000000,gpio[15:8]} : 0;
  assign gpio[0] = direction[0] ? gpio_a[0] : 1'bz;
  
  always @(negedge clk)
      begin
        if (de && (!rst && drw[0])) 
          begin
            if (daddr == 32'h00000000) direction <= din[15:0];
            else if (daddr == 32'h00000004) gpio_a <= din[7:0];
            else if (daddr == 32'h00000008) gpio_b <= din[7:0];
              
          end
        else if (rst) 
          begin
            gpio_a <= 8'h00;
            gpio_b <= 8'h00;
            direction <= 16'h0000;
          end
          
      end
endmodule

