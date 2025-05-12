module test_case ( ) ;
   parameter simulation_name = "burst_00";
   parameter number_of_tests = 15;
   reg  err;
   reg [31:0] data_out;
   reg [15:0] i;
   reg [15:0] index ;
   reg [(16*7):0] write_mem = 0;
   reg [(16*7):0] read_mem  = 0;
   initial begin
      $display("Test 00 Case");
      `TB.master_bfm.reset;
      @(posedge `WB_RST);
      @(negedge `WB_RST);
      @(posedge `WB_CLK);
      @(negedge `ADXL362_RESET);
      `SIMPLE_SPI_INIT;
      `ADXL362_WRITE_DOUBLE_REGISTER(`ADXL362_THRESH_ACT_LOW, 16'h6507);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_THRESH_ACT_LOW, 16'h507);
      repeat(100) @(posedge `WB_CLK);
      for (i = 0; i< 14; i= i+1) begin
         write_mem[(i*8)+7 -: 8] = i | 8'h80;
      end
      repeat(100) @(posedge `WB_CLK);
      `ADXL362_WRITE_BURST_REGISTERS(`ADXL362_THRESH_ACT_LOW, write_mem, 14);
      repeat(50) @(posedge `WB_CLK);
      `ADXL362_READ_BURST_REGISTERS(`ADXL362_THRESH_ACT_LOW, read_mem, 14);
      `TEST_COMPARE("Reg 0",  8'h80, read_mem[7:0]);
      `TEST_COMPARE("Reg 1",  8'h01, read_mem[15:8]);
      `TEST_COMPARE("Reg 2",  8'h82, read_mem[23:16]);
      `TEST_COMPARE("Reg 3",  8'h83, read_mem[31:24]);
      `TEST_COMPARE("Reg 4",  8'h04, read_mem[39:32]);
      `TEST_COMPARE("Reg 5",  8'h85, read_mem[47:40]);
      `TEST_COMPARE("Reg 6",  8'h86, read_mem[55:48]);
      `TEST_COMPARE("Reg 7",  8'h00, read_mem[63:56]);
      `TEST_COMPARE("Reg 8",  8'h08, read_mem[71:64]);
      `TEST_COMPARE("Reg 9",  8'h89, read_mem[79:72]);
      `TEST_COMPARE("Reg 10", 8'h8a, read_mem[87:80]);
      `TEST_COMPARE("Reg 11", 8'h8b, read_mem[95:88]);
      `TEST_COMPARE("Reg 12", 8'h8c, read_mem[103:96]);
      `TEST_COMPARE("Reg 13", 8'h8d, read_mem[111:104]);
      repeat(10) @(posedge `WB_CLK);
      `TEST_COMPLETE;
   end
endmodule