
module true_dualport_ram_clear  #(parameter  ADDRLEN = 10, DATALEN = 1+1, DEPTH = 1024)
  (input  wire clka,
   input  wire [(-1)+ADDRLEN:0] addra,
   output reg [(-1)+DATALEN:0] rdataa,
   input  wire [(-1)+DATALEN:0] wdataa,
   input  wire wea,
   input  wire clkb,
   input  wire [(-1)+ADDRLEN:0] addrb,
   output reg [(-1)+DATALEN:0] rdatab,
   input  wire [(-1)+DATALEN:0] wdatab,
   input  wire web,
   input  wire clear);

  reg  [(-1)+DATALEN:0] mem[0:DEPTH-1];
  integer i;

  
  always @(*)
      begin
        if (clear) 
          begin
            for (i = 0; i < DEPTH; i = 1+i)
                mem[i] = 0;
          end
          
      end
  
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

