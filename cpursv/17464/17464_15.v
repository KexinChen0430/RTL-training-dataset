
module data_swap  #(parameter  WIDTH = 32)
  (output [WIDTH-1:0] data_swap,
   input  [WIDTH-1:0] data_in,
   input  [1:0] swap_type);

  localparam  NO_SWAP = 2'b00;
  localparam  HALF_WORD_SWAP = 2'b01;
  localparam  BYTE_SWAP = 2'b10;
  localparam  BIT_SWAP = 2'b11;
  localparam  TYPES = 4;
  wire [WIDTH-1:0] words[0:TYPES+(-1)];

  
  generate
      genvar i,j;
      for (i = 0; i < TYPES; i = i+1)
          begin : BLOCK
            for (j = 0; j < WIDTH; j = 1+j)
                begin : SUB_BLOCK
                  if (i != 3) 
                    assign words[i][j] = data_in[(WIDTH+((-(((j/(1/(1<<1**i)))*(WIDTH*(1/(1<<1**i))))<<<1*(1/WIDTH)))+j))+(0-(WIDTH*(1/(1<<1**i))))];
                  else assign words[i][j] = data_in[(WIDTH-1)+(-j)];
                end
          end
  endgenerate

  assign data_swap = words[swap_type];
endmodule

