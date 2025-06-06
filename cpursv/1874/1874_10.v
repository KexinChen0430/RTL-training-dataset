
module MReSC_example(input  [2:0] x_1,
                     input  [4:0] x_2,
                     input  [1:0] x_3,
                     input  [71:0] w,
                     output reg z);

  wire [1:0] sum_1;

  assign sum_1 = x_1[2]+(x_1[1]+x_1[0]);
  wire [2:0] sum_2;

  assign sum_2 = x_2[4]+((x_2[1]+(x_2[0]+x_2[3]))+x_2[2]);
  wire sum_3;

  assign sum_3 = x_3[1]+x_3[0];
  
  always @(*)
      begin
        case (sum_1)

          2'd0: case (sum_2)

                3'd0: case (sum_3)

                      1'd0: z = w[0];

                      1'd1: z = w[1];

                      1'd2: z = w[2];

                      default: z = 0;

                    endcase


                3'd1: case (sum_3)

                      1'd0: z = w[3];

                      1'd1: z = w[4];

                      1'd2: z = w[5];

                      default: z = 0;

                    endcase


                3'd2: case (sum_3)

                      1'd0: z = w[6];

                      1'd1: z = w[7];

                      1'd2: z = w[8];

                      default: z = 0;

                    endcase


                3'd3: case (sum_3)

                      1'd0: z = w[9];

                      1'd1: z = w[10];

                      1'd2: z = w[11];

                      default: z = 0;

                    endcase


                3'd4: case (sum_3)

                      1'd0: z = w[12];

                      1'd1: z = w[13];

                      1'd2: z = w[14];

                      default: z = 0;

                    endcase


                3'd5: case (sum_3)

                      1'd0: z = w[15];

                      1'd1: z = w[16];

                      1'd2: z = w[17];

                      default: z = 0;

                    endcase


                default: z = 0;

              endcase


          2'd1: case (sum_2)

                3'd0: case (sum_3)

                      1'd0: z = w[18];

                      1'd1: z = w[19];

                      1'd2: z = w[20];

                      default: z = 0;

                    endcase


                3'd1: case (sum_3)

                      1'd0: z = w[21];

                      1'd1: z = w[22];

                      1'd2: z = w[23];

                      default: z = 0;

                    endcase


                3'd2: case (sum_3)

                      1'd0: z = w[24];

                      1'd1: z = w[25];

                      1'd2: z = w[26];

                      default: z = 0;

                    endcase


                3'd3: case (sum_3)

                      1'd0: z = w[27];

                      1'd1: z = w[28];

                      1'd2: z = w[29];

                      default: z = 0;

                    endcase


                3'd4: case (sum_3)

                      1'd0: z = w[30];

                      1'd1: z = w[31];

                      1'd2: z = w[32];

                      default: z = 0;

                    endcase


                3'd5: case (sum_3)

                      1'd0: z = w[33];

                      1'd1: z = w[34];

                      1'd2: z = w[35];

                      default: z = 0;

                    endcase


                default: z = 0;

              endcase


          2'd2: case (sum_2)

                3'd0: case (sum_3)

                      1'd0: z = w[36];

                      1'd1: z = w[37];

                      1'd2: z = w[38];

                      default: z = 0;

                    endcase


                3'd1: case (sum_3)

                      1'd0: z = w[39];

                      1'd1: z = w[40];

                      1'd2: z = w[41];

                      default: z = 0;

                    endcase


                3'd2: case (sum_3)

                      1'd0: z = w[42];

                      1'd1: z = w[43];

                      1'd2: z = w[44];

                      default: z = 0;

                    endcase


                3'd3: case (sum_3)

                      1'd0: z = w[45];

                      1'd1: z = w[46];

                      1'd2: z = w[47];

                      default: z = 0;

                    endcase


                3'd4: case (sum_3)

                      1'd0: z = w[48];

                      1'd1: z = w[49];

                      1'd2: z = w[50];

                      default: z = 0;

                    endcase


                3'd5: case (sum_3)

                      1'd0: z = w[51];

                      1'd1: z = w[52];

                      1'd2: z = w[53];

                      default: z = 0;

                    endcase


                default: z = 0;

              endcase


          2'd3: case (sum_2)

                3'd0: case (sum_3)

                      1'd0: z = w[54];

                      1'd1: z = w[55];

                      1'd2: z = w[56];

                      default: z = 0;

                    endcase


                3'd1: case (sum_3)

                      1'd0: z = w[57];

                      1'd1: z = w[58];

                      1'd2: z = w[59];

                      default: z = 0;

                    endcase


                3'd2: case (sum_3)

                      1'd0: z = w[60];

                      1'd1: z = w[61];

                      1'd2: z = w[62];

                      default: z = 0;

                    endcase


                3'd3: case (sum_3)

                      1'd0: z = w[63];

                      1'd1: z = w[64];

                      1'd2: z = w[65];

                      default: z = 0;

                    endcase


                3'd4: case (sum_3)

                      1'd0: z = w[66];

                      1'd1: z = w[67];

                      1'd2: z = w[68];

                      default: z = 0;

                    endcase


                3'd5: case (sum_3)

                      1'd0: z = w[69];

                      1'd1: z = w[70];

                      1'd2: z = w[71];

                      default: z = 0;

                    endcase


                default: z = 0;

              endcase


          default: z = 0;

        endcase

      end
endmodule

