
module mod_uart(rst,clk,ie,de,iaddr,daddr,drw,din,iout,dout,txd,rxd,i_uart,
                pmc_uart_recv,pmc_uart_send);

  input  rst;
  input  clk;
  input  ie,de;
  input  [31:0] iaddr,daddr;
  input  [1:0] drw;
  input  [31:0] din;
  output [31:0] iout,dout;
  output txd;
  input  rxd;
  output i_uart;
  output pmc_uart_recv,pmc_uart_send;
  wire [31:0] idata,ddata;

  assign iout = idata;
  assign dout = ddata;
  assign idata = 32'h00000000;
  wire data_rdy,cts,send,clear;

  wire [7:0] in_buffer;

  reg  [7:0] out_buffer;

  uart_core uart(clk,rxd,txd,in_buffer,out_buffer,data_rdy,clear,cts,
                 send,rst);
  assign send = ((daddr == 32'h0) && (drw[0] && de)) ? din[0] : 0;
  assign clear = ((daddr == 32'h0) && (drw[0] && de)) ? din[1] : 0;
  assign pmc_uart_recv = clear;
  assign pmc_uart_send = send;
  assign ddata = (daddr == 32'h0) ? 0 : 
                 (daddr == 32'h4) ? {30'h0,data_rdy,cts} : 
                 (daddr == 32'h8) ? {24'h0,in_buffer} : 
                 (daddr == 32'hc) ? {24'h0,out_buffer} : 0;
  assign i_uart = data_rdy;
  
  always @(negedge clk)
      begin
        if (drw[0] && ((daddr == 32'hc) && de)) out_buffer = din[7:0];
          
      end
endmodule

