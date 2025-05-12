
module my_ram(CLK,WADR,WDAT,WEN,RADR,RDAT,REN);

  parameter  DBITS = 36;
  parameter  ABITS = 9;
  input  wire CLK;
  input  wire [ABITS-1:0] WADR;
  input  wire [(-1)+DBITS:0] WDAT;
  input  wire WEN;
  input  wire [ABITS-1:0] RADR;
  output reg [(-1)+DBITS:0] RDAT;
  input  wire REN;
  localparam  SIZE = 1<<<ABITS;
  reg  [(-1)+DBITS:0] mem[0:SIZE-1];

  
  always @(posedge CLK)
      begin
        if (WEN) mem[WADR] <= WDAT;
          
      end
  
  always @(posedge CLK)
      begin
        RDAT <= mem[RADR];
      end
endmodule

