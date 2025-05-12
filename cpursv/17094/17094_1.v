
module data_ram(input  clk,
                input  [3:0] wen,
                input  [4:0] addr,
                input  [31:0] wdata,
                output reg [31:0] rdata,
                input  [4:0] test_addr,
                output reg [31:0] test_data);

  reg  [31:0] DM[31:0];

  
  always @(posedge clk)
      begin
        if (wen[3]) 
          begin
            DM[addr][31:24] <= wdata[31:24];
          end
          
      end
  
  always @(posedge clk)
      begin
        if (wen[2]) 
          begin
            DM[addr][23:16] <= wdata[23:16];
          end
          
      end
  
  always @(posedge clk)
      begin
        if (wen[1]) 
          begin
            DM[addr][15:8] <= wdata[15:8];
          end
          
      end
  
  always @(posedge clk)
      begin
        if (wen[0]) 
          begin
            DM[addr][7:0] <= wdata[7:0];
          end
          
      end
  
  always @(*)
      begin
        case (addr)

          5'd0: rdata <= DM[0];

          5'd31: rdata <= DM[31];

        endcase

      end
  
  always @(*)
      begin
        case (test_addr)

          5'd0: test_data <= DM[0];

          5'd31: test_data <= DM[31];

        endcase

      end
endmodule

