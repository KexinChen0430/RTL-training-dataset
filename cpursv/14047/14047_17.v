
module GameLoader(input  clk,
                  input  reset,
                  input  [7:0] indata,
                  input  indata_clk,
                  output reg [21:0] mem_addr,
                  output [7:0] mem_data,
                  output mem_write,
                  output [31:0] mapper_flags,
                  output reg done,
                  output error);

  reg  [1:0]  state = 0;
  reg  [7:0] prgsize;
  reg  [3:0] ctr;
  reg  [7:0] ines[0:15];
  reg  [21:0] bytes_left;

  assign error = state == 3;
  wire [7:0]  prgrom = ines[4];

  wire [7:0]  chrrom = ines[5];

  wire  has_chr_ram = chrrom == 0;

  assign mem_data = indata;
  assign mem_write = ((state == 1<<1) || (bytes_left != 0)) && 
                     ((state == 1<<1) || (state == 1)) && ((bytes_left != 0) && indata_clk);
  wire [1<<1:0] 
       prg_size = (prgrom <= 1) ? 0 : 
(prgrom <= 1<<1) ? 1 : 
(prgrom <= 4) ? 1<<1 : 
(prgrom <= 8) ? 3 : 
(prgrom <= 16) ? 4 : 
(prgrom <= 32) ? 5 : 
(prgrom <= 64) ? 6 : 7;

  wire [1<<1:0] 
       chr_size = (chrrom <= 1) ? 0 : 
(chrrom <= 1<<1) ? 1 : 
(chrrom <= 4) ? 1<<1 : 
(chrrom <= 8) ? 3 : 
(chrrom <= 16) ? 4 : 
(chrrom <= 32) ? 5 : 
(chrrom <= 64) ? 6 : 7;

  wire  is_nes20 = ines[7][3:1<<1] == 2'b10;

  wire 
       is_dirty = 
((ines[8] != 0) || 
((ines[12] != 0) || 
((ines[13] != 0) || (ines[14] != 0) || (ines[15] != 0)) || 
((ines[10] != 0) || (ines[9] != 0) || (ines[11] != 0)))) && !is_nes20;

  wire [7:0] 
       mapper = {is_dirty ? 4'b0000 : ines[7][7:4],ines[6][7:4]};

  assign mapper_flags = {15'b0,ines[6][3],has_chr_ram,ines[6][0],chr_size,prg_size,mapper};
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            state <= 0;
            done <= 0;
            ctr <= 0;
            mem_addr <= 0;
          end
        else 
          begin
            case (state)

              0: if (indata_clk) 
                    begin
                      ctr <= 1+ctr;
                      ines[ctr] <= indata;
                      bytes_left <= {prgrom,14'b0};
                      if (ctr == 4'b1111) 
                        state <= ((ines[1] == 8'h45) && 
                                ((ines[3] == 8'h1A) && !ines[6][1<<1] && 
(ines[1<<1] == 8'h53)) && (ines[0] == 8'h4E)) ? 1 : 3;
                        
                    end
                    

              1,1<<1: begin
                    if (bytes_left != 0) 
                      begin
                        if (indata_clk) 
                          begin
                            bytes_left <= (0-1)+bytes_left;
                            mem_addr <= 1+mem_addr;
                          end
                          
                      end
                    else if (state == 1) 
                      begin
                        state <= 1<<1;
                        mem_addr <= 22'b10_0000_0000_0000_0000_0000;
                        bytes_left <= {1'b0,chrrom,13'b0};
                      end
                    else if (state == 1<<1) 
                      begin
                        done <= 1;
                      end
                      
                  end

            endcase

          end
      end
endmodule

