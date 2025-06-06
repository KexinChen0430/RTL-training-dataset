
module wb_readback_mux_16LE(input  wb_clk_i,
                            input  wb_rst_i,
                            input  wb_stb_i,
                            input  [15:0] wb_adr_i,
                            output [15:0] wb_dat_o,
                            output reg wb_ack_o,
                            input  [31:0] word00,
                            input  [31:0] word01,
                            input  [31:0] word02,
                            input  [31:0] word03,
                            input  [31:0] word04,
                            input  [31:0] word05,
                            input  [31:0] word06,
                            input  [31:0] word07,
                            input  [31:0] word08,
                            input  [31:0] word09,
                            input  [31:0] word10,
                            input  [31:0] word11,
                            input  [31:0] word12,
                            input  [31:0] word13,
                            input  [31:0] word14,
                            input  [31:0] word15);

  wire  ack_next = ~wb_ack_o & wb_stb_i;

  
  always @(posedge wb_clk_i)
      if (wb_rst_i) wb_ack_o <= 0;
      else wb_ack_o <= ack_next;
  reg  [31:0] data;

  assign wb_dat_o = data[15:0];
  
  always @(posedge wb_clk_i)
      if (ack_next & wb_adr_i[1]) 
        begin
          data[15:0] <= data[31:16];
        end
      else if (ack_next & ~wb_adr_i[1]) 
        begin
          case (wb_adr_i[5:2])

            0: data <= word00;

            1: data <= word01;

            2: data <= word02;

            3: data <= word03;

            4: data <= word04;

            5: data <= word05;

            6: data <= word06;

            7: data <= word07;

            8: data <= word08;

            9: data <= word09;

            10: data <= word10;

            11: data <= word11;

            12: data <= word12;

            13: data <= word13;

            14: data <= word14;

            15: data <= word15;

          endcase

        end
        
endmodule

