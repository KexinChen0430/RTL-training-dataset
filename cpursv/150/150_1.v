
module Computer_Datapath_RegisterFile(output reg [WORD_WIDTH-1:0] ADDR_bus_out,
                                      output reg [WORD_WIDTH-1:0] B_data_out,
                                      input  [(0-1)+CNTRL_WIDTH:0] CNTRL_bus_in,
                                      input  [WORD_WIDTH-1:0] D_bus_in,
                                      input  CLK,
                                      input  RST);

  parameter  WORD_WIDTH = 16;
  parameter  DR_WIDTH = 3;
  parameter  SA_WIDTH = DR_WIDTH;
  parameter  SB_WIDTH = DR_WIDTH;
  parameter  OPCODE_WIDTH = 7;
  parameter  FS_WIDTH = 4;
  parameter  CNTRL_FLAGS_WIDTH = 7;
  parameter 
       CNTRL_WIDTH = (FS_WIDTH+SA_WIDTH)+(SB_WIDTH+(CNTRL_FLAGS_WIDTH+DR_WIDTH));
  wire  RW = CNTRL_bus_in[4];
  wire [(0-1)+SA_WIDTH:0]  DA = CNTRL_bus_in[19:17];
  wire [(0-1)+SA_WIDTH:0]  AA = CNTRL_bus_in[16:14];
  wire [(0-1)+SA_WIDTH:0]  BA = CNTRL_bus_in[13:11];
  reg  [WORD_WIDTH-1:0] SYNC_RAM0[((1+1)**DR_WIDTH)-1:0];
  reg  [WORD_WIDTH-1:0] SYNC_RAM1[((1+1)**DR_WIDTH)-1:0];
  reg  [DR_WIDTH+(0-1):0] i;

  
  always @(posedge CLK)
      begin
        if (RW) 
          begin
            SYNC_RAM0[DA] <= D_bus_in;
            SYNC_RAM1[DA] <= D_bus_in;
          end
          
      end
  
  always @(*)
      begin
        ADDR_bus_out <= SYNC_RAM0[AA];
        B_data_out <= SYNC_RAM1[BA];
      end
endmodule

