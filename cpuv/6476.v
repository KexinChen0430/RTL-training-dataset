module spi ( 
    input wire 	      clk, 
    input wire 	      resn, 
    input wire 	      trig, 
    output wire       done, 
    output reg [15:0] rdData, 
    input wire [15:0] wrData, 
    output reg 	      SCLK, 
    output reg 	      SS, 
    output reg 	      MOSI, 
    input wire 	      MISO 
    );
   reg [3:0] 		      state; 
   reg [15:0] 		      bitCount; 
   reg [15:0] 		      clkCounter; 
   always @ (posedge clk) begin 
      clkCounter = clkCounter + 1; 
      if (clkCounter == 33) begin 
         SCLK <= !SCLK; 
      end
   end
   always @ (SCLK) begin 
      if (!resn) begin 
         SS <= 1; 
         MOSI <= 0; 
         state <= 0; 
         bitCount <= 0; 
      end else begin 
         case (state) 
           0: begin 
              if (trig) begin 
                 if (SCLK == 0) begin 
                    SS <= 0; 
                    state <= 1; 
                    bitCount <= 15; 
                 end
              end
           end
           1: begin 
              if (SCLK == 0) begin 
                 MOSI <= wrData[bitCount]; 
                 bitCount <= bitCount - 1; 
                 if (bitCount == 0) begin 
                    state <= 2; 
                 end
              end else begin 
                 rdData[bitCount] <= MISO; 
              end
           end
           2: begin 
              if (SCLK == 1) begin 
                 SS <= 1; 
                 MOSI <= 0; 
                 state <= 0; 
                 bitCount <= 0; 
              end
           end
           default: ; 
         endcase
      end
   end
   assign done = SS; 
endmodule