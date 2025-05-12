
module true_dualport_ram  #(parameter  ADDRLEN = 10, DATALEN = 2, DEPTH = 1024)
  (input  wire clka,
   input  wire [(0-1)+ADDRLEN:0] addra,
   output reg [(0-1)+DATALEN:0] rdataa,
   input  wire [(0-1)+DATALEN:0] wdataa,
   input  wire wea,
   input  wire clkb,
   input  wire [(0-1)+ADDRLEN:0] addrb,
   output reg [(0-1)+DATALEN:0] rdatab,
   input  wire [(0-1)+DATALEN:0] wdatab,
   input  wire web);

  reg  [(0-1)+DATALEN:0] mem[0:(0-1)+DEPTH];

  
  always @(posedge clka)
      begin
        rdataa <= mem[addra];
        if (wea) 
          begin
            mem[addra] <= wdataa;
          end
          
      end
  
  always @(posedge clkb)
      begin
        rdatab <= mem[addrb];
        if (web) 
          begin
            mem[addrb] <= wdatab;
          end
          
      end
endmodule

