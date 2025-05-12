
module sirv_mrom  #(parameter  AW = 12, DW = 32, DP = 1024)
  (input  [AW-1:1<<1] rom_addr,
   output [DW-1:0] rom_dout);

  wire [31:0] mask_rom[0:(0-1)+DP];

  assign rom_dout = mask_rom[rom_addr];
  genvar i;
  
  generate
      if (1) 
        begin : jump_to_ram_gen
          for (i = 0; i < 1024; i = 1+i)
              begin : rom_gen
                if (i == 0) 
                  begin : rom0_gen
                    assign mask_rom[i] = 32'h7ffff297;
                  end
                else if (i == 1) 
                  begin : rom1_gen
                    assign mask_rom[i] = 32'h00028067;
                  end
                else 
                  begin : rom_non01_gen
                    assign mask_rom[i] = 32'h00000000;
                  end
              end
        end
      else 
        begin : jump_to_non_ram_gen
          for (i = 0; i < 1024; i = 1+i)
              begin : rom_gen

              end
        end
  endgenerate

endmodule

