
module MIO_BUS(input  wire [31:0] dat_i,
               input  wire [31:0] adr_i,
               input  wire we_i,
               input  wire stb_i,
               output reg [31:0] dat_o,
               output ack_o,
               input  wire clk,
               input  wire rst,
               input  wire [3:0] BTN,
               input  wire [7:0] SW,
               input  wire [31:0] counter_out,
               input  wire counter0_out,
               input  wire counter1_out,
               input  wire counter2_out,
               input  wire [7:0] led_out,
               output reg GPIOffffff00_we,
               output reg GPIOfffffe00_we,
               output reg counter_we,
               output reg [31:0] Peripheral_in);

  reg  [31:0] Cpu_data2bus;
  reg  [31:0] Cpu_data4bus;
  wire wea;

  assign ack_o = stb_i;
  assign wea = stb_i & (ack_o & we_i);
  
  always @(posedge clk)
      begin
        if (ack_o & stb_i) 
          begin
            if (we_i) 
              begin
                Cpu_data2bus <= dat_i;
              end
            else 
              begin
                dat_o <= Cpu_data4bus;
              end
          end
          
      end
  
  always @* 
      begin
        counter_we = 0;
        GPIOffffff00_we = 0;
        GPIOfffffe00_we = 0;
        Peripheral_in = 32'h0;
        Cpu_data4bus = 32'h0;
        casex (adr_i[31:8])

          24'hfffffe: begin
                GPIOfffffe00_we = wea;
                Peripheral_in = Cpu_data2bus;
                Cpu_data4bus = counter_out;
              end

          24'hffffff: begin
                if (adr_i[2]) 
                  begin
                    counter_we = wea;
                    Peripheral_in = Cpu_data2bus;
                    Cpu_data4bus = counter_out;
                  end
                else 
                  begin
                    GPIOffffff00_we = wea;
                    Peripheral_in = Cpu_data2bus;
                    Cpu_data4bus = {counter0_out,counter1_out,counter2_out,9'h000,led_out,BTN,SW};
                  end
              end

        endcase

      end
endmodule

