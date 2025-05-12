
module sramcontroller(want_addr,addr_ready,addrin,want_data,data_ready,datain,addr,
                      addrvalid,data,datavalid,tm3_sram_data_in,tm3_sram_data_out,
                      tm3_sram_addr,tm3_sram_we,tm3_sram_oe,tm3_sram_adsp,
                      globalreset,clk,statepeek);

  output want_addr;
  reg  want_addr;
  input  addr_ready;
  input  [17:0] addrin;
  output want_data;
  reg  want_data;
  input  data_ready;
  input  [63:0] datain;
  input  [17:0] addr;
  input  addrvalid;
  output [63:0] data;
  reg  [63:0] data;
  reg  [63:0] temp_data;
  output datavalid;
  reg  datavalid;
  reg  temp_datavalid;
  input  [63:0] tm3_sram_data_in;
  wire [63:0] tm3_sram_data_in;
  output [63:0] tm3_sram_data_out;
  wire [63:0] tm3_sram_data_out;
  reg  [63:0] tm3_sram_data_xhdl0;
  output [18:0] tm3_sram_addr;
  reg  [18:0] tm3_sram_addr;
  output [7:0] tm3_sram_we;
  reg  [7:0] tm3_sram_we;
  output [1:0] tm3_sram_oe;
  reg  [1:0] tm3_sram_oe;
  output tm3_sram_adsp;
  reg  tm3_sram_adsp;
  input  globalreset;
  input  clk;
  output [2:0] statepeek;
  reg  [2:0] statepeek;
  reg  [2:0] temp_statepeek;
  reg  [2:0] state;
  reg  [2:0] next_state;
  reg  [17:0] waddress;
  reg  [17:0] temp_waddress;

  assign tm3_sram_data_out = tm3_sram_data_xhdl0;
  
  always @(posedge clk or posedge globalreset)
      begin
        if (globalreset == 1'b1) 
          begin
            state <= 0;
            waddress <= 0;
            data <= 0;
            datavalid <= 1'b0;
          end
        else 
          begin
            state <= next_state;
            statepeek <= temp_statepeek;
            data <= temp_data;
            datavalid <= temp_datavalid;
            waddress <= temp_waddress;
          end
      end
  
  always @(state or addr_ready or data_ready or waddress or datain or addrvalid or datavalid or addr)
      begin
        case (state)

          0: begin

              end

          1: begin

              end

          2: begin

              end

          3: begin

              end

          4: begin

              end

          5: begin

              end

        endcase

      end
endmodule

