module Mapper28(input clk, input ce, input reset,
                input [31:0] flags,
                input [15:0] prg_ain, output [21:0] prg_aout,
                input prg_read, prg_write,                   
                input [7:0] prg_din,
                output prg_allow,                            
                input [13:0] chr_ain, output [21:0] chr_aout,
                output chr_allow,                      
                output reg vram_a10,                         
                output vram_ce);                             
    reg [6:0] a53prg;    
    reg [1:0] a53chr;    
    reg [3:0] inner;    
    reg [5:0] mode;     
    reg [5:0] outer;    
    reg [1:0] selreg;   
    wire [7:0] mapper = flags[7:0];
    wire allow_select = (mapper == 8'd28);
    always @(posedge clk) if (reset) begin
      mode[5:2] <= 0;         
      outer[5:0] <= 6'h3f;    
      inner <= 0;
      selreg <= 1;
      if (mapper == 2 || mapper == 0 || mapper == 3)
        mode[1:0] <= flags[14] ? 2'b10 : 2'b11;
      if (mapper == 2)
        mode[5:2] <= 4'b1111;
      if (mapper == 3)
        selreg <= 0;
      if (mapper == 7) begin
        mode[1:0] <= 2'b00;   
        mode[5:2] <= 4'b1100; 
      end
    end else if (ce) begin
      if ((prg_ain[15:12] == 4'h5) & prg_write && allow_select) selreg <= {prg_din[7], prg_din[0]};        
      if (prg_ain[15] & prg_write) begin
        case (selreg)
        2'h0:  {mode[0], a53chr}  <= {(mode[1] ? mode[0] : prg_din[4]), prg_din[1:0]};  
        2'h1:  {mode[0], inner}   <= {(mode[1] ? mode[0] : prg_din[4]), prg_din[3:0]};  
        2'h2:  {mode}             <= {prg_din[5:0]};                                    
        2'h3:  {outer}            <= {prg_din[5:0]};                                    
        endcase
      end
    end
    always begin
      casez(mode[1:0])
      2'b0?   :   vram_a10 = {mode[0]};        
      2'b10   :   vram_a10 = {chr_ain[10]};    
      2'b11   :   vram_a10 = {chr_ain[11]};    
      endcase
      casez({mode[5:2], prg_ain[14]})
      5'b00_0?_?  :  a53prg = {outer[5:0],             prg_ain[14]};  
      5'b01_0?_?  :  a53prg = {outer[5:1], inner[0],   prg_ain[14]};  
      5'b10_0?_?  :  a53prg = {outer[5:2], inner[1:0], prg_ain[14]};  
      5'b11_0?_?  :  a53prg = {outer[5:3], inner[2:0], prg_ain[14]};  
      5'b00_10_1,
      5'b00_11_0  :  a53prg = {outer[5:0], inner[0]};             
      5'b01_10_1,
      5'b01_11_0  :  a53prg = {outer[5:1], inner[1:0]};           
      5'b10_10_1,
      5'b10_11_0  :  a53prg = {outer[5:2], inner[2:0]};           
      5'b11_10_1,
      5'b11_11_0  :  a53prg = {outer[5:3], inner[3:0]};           
      default     :  a53prg = {outer[5:0],             prg_ain[14]};  
      endcase
    end
    assign vram_ce = chr_ain[13];
    assign prg_aout = {1'b0, (a53prg & 7'b0011111), prg_ain[13:0]};
    assign prg_allow = prg_ain[15] && !prg_write;
    assign chr_allow = flags[15];
    assign chr_aout = {7'b10_0000_0, a53chr, chr_ain[12:0]};
endmodule