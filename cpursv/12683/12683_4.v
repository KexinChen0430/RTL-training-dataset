
module gpio_core  #(parameter 
       ABUSWIDTH    = 16,
       IO_WIDTH     = 8,
       IO_DIRECTION = 0,
       IO_TRI       = 0)
  (BUS_CLK,BUS_RST,BUS_ADD,BUS_DATA_IN,BUS_DATA_OUT,BUS_RD,
                 BUS_WR,IO);

  localparam  VERSION = 0;
  input  wire BUS_CLK;
  input  wire BUS_RST;
  input  wire [(0-1)+ABUSWIDTH:0] BUS_ADD;
  input  wire [7:0] BUS_DATA_IN;
  output reg [7:0] BUS_DATA_OUT;
  input  wire BUS_RD;
  input  wire BUS_WR;
  inout  wire [IO_WIDTH-1:0] IO;
  wire SOFT_RST;
  localparam  IO_BYTES = 1+((IO_WIDTH-1)*(1/8));
  reg  [7:0] INPUT_DATA[(0-1)+IO_BYTES:0];
  reg  [7:0] OUTPUT_DATA[(0-1)+IO_BYTES:0];
  reg  [7:0] DIRECTION_DATA[(0-1)+IO_BYTES:0];

  
  always @(posedge BUS_CLK)
      begin
        if (BUS_RD) 
          begin
            if (BUS_ADD == 0) BUS_DATA_OUT <= VERSION;
            else if ((BUS_ADD+(0-1)) < IO_BYTES) BUS_DATA_OUT <= INPUT_DATA[(-BUS_ADD)+IO_BYTES];
            else if (((0-(IO_BYTES+1))+BUS_ADD) < IO_BYTES) BUS_DATA_OUT <= OUTPUT_DATA[(-BUS_ADD)+(IO_BYTES*1<<<1)];
            else if (((-(1+(IO_BYTES*1<<<1)))+BUS_ADD) < IO_BYTES) BUS_DATA_OUT <= DIRECTION_DATA[(IO_BYTES*3)-BUS_ADD];
              
          end
          
      end
  assign SOFT_RST = BUS_WR && (BUS_ADD == 0);
  wire RST;

  assign RST = SOFT_RST | BUS_RST;
  integer bi;

  
  always @(posedge BUS_CLK)
      begin
        if (RST) 
          begin
            for (bi = 0; bi < IO_BYTES; bi = 1+bi)
                begin
                  DIRECTION_DATA[bi] <= 0;
                  OUTPUT_DATA[bi] <= 0;
                end
          end
        else if (BUS_WR) 
          begin
            if ((BUS_ADD+(0-1)) < IO_BYTES) 
               ;
            else if (((0-(IO_BYTES+1))+BUS_ADD) < IO_BYTES) OUTPUT_DATA[(-BUS_ADD)+(IO_BYTES*1<<<1)] <= BUS_DATA_IN;
            else if (((-(1+(IO_BYTES*1<<<1)))+BUS_ADD) < IO_BYTES) DIRECTION_DATA[(IO_BYTES*3)-BUS_ADD] <= BUS_DATA_IN;
              
          end
          
      end
  genvar i;
  
  generate
      for (i = 0; i < IO_WIDTH; i = i+1)
          begin : sreggen
            if (IO_TRI[i]) 
              assign IO[i] = DIRECTION_DATA[i*(1/8)][i%8] ? OUTPUT_DATA[i*(1/8)][i%8] : 1'bz;
            else if (IO_DIRECTION[i]) assign IO[i] = OUTPUT_DATA[i*(1/8)][i%8];
              
          end
  endgenerate

  
  always @(*)
      for (bi = 0; bi < IO_WIDTH; bi = 1+bi)
          INPUT_DATA[(1/8)*bi][(bi*(1%8))%8] = IO[bi];
endmodule

