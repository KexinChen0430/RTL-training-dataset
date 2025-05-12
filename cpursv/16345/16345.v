
module wb_bus_writer(input  start,
                     output done,
                     output reg [15:0] rom_addr,
                     input  [47:0] rom_data,
                     input  wb_clk_i,
                     input  wb_rst_i,
                     output [31:0] wb_dat_o,
                     input  wb_ack_i,
                     output [15:0] wb_adr_o,
                     output wb_cyc_o,
                     output [3:0] wb_sel_o,
                     output wb_stb_o,
                     output wb_we_o);

  reg  [3:0] state;

  assign done = (state != 0) && &rom_data;
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) 
        begin
          rom_addr <= #1 0;
          state <= #1 0;
        end
      else if (start) 
        begin
          rom_addr <= #1 0;
          state <= #1 1;
        end
      else if ((state == 1) && wb_ack_i) 
        if (done) state <= #1 0;
        else rom_addr <= #1 rom_addr+1;
        
  assign wb_dat_o = rom_data[31:0];
  assign wb_adr_o = rom_data[47:32];
  assign wb_sel_o = 4'b1111;
  assign wb_cyc_o = !done & (state != 0);
  assign wb_stb_o = !done & (state != 0);
  assign wb_we_o = !done & (state != 0);
endmodule

