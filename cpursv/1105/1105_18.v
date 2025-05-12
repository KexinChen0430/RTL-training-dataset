
module shift_mux_array  #(parameter  SWR = 26, LEVEL = 5)
  (input  wire [(-1)+SWR:0] Data_i,
   input  wire select_i,
   input  wire bit_shift_i,
   output wire [(-1)+SWR:0] Data_o);

  genvar j;
  localparam integer  lvl = (1+1)**LEVEL;

  localparam integer  x = (-1)+SWR;

  
  generate
      for (j = 0; j <= ((-1)+SWR); j = 1+j)
          begin : MUX_ODDNORM
            localparam integer  sh = ((1+1)**LEVEL)+j;

            case ((lvl+j) > x)

              1'b1: begin : BSHITMUX
                    assign Data_o[j] = select_i ? bit_shift_i : Data_i[j];
                  end

              1'b0: begin : FSHITMUX
                    assign Data_o[j] = select_i ? Data_i[lvl+j] : Data_i[j];
                  end

            endcase

          end
  endgenerate

endmodule

