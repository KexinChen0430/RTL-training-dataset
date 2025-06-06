
module load_data_translator(d_readdatain,d_address,load_size,load_sign_ext,d_loadresult);

  parameter  WIDTH = 32;
  input  [WIDTH-1:0] d_readdatain;
  input  [1:0] d_address;
  input  [1:0] load_size;
  input  load_sign_ext;
  output [WIDTH-1:0] d_loadresult;
  reg  [WIDTH-1:0] d_loadresult;

  
  always @(d_readdatain or d_address or load_size or load_sign_ext)
      begin
        case (load_size)

          2'b11: begin
                case (d_address[1:0])

                  0: d_loadresult[7:0] = d_readdatain[31:24];

                  1: d_loadresult[7:0] = d_readdatain[23:16];

                  1<<<1: d_loadresult[7:0] = d_readdatain[15:8];

                  default: d_loadresult[7:0] = d_readdatain[7:0];

                endcase

                d_loadresult[31:8] = {24{d_loadresult[7] & load_sign_ext}};
              end

          2'b01: begin
                case (d_address[1])

                  0: d_loadresult[15:0] = d_readdatain[31:16];

                  default: d_loadresult[15:0] = d_readdatain[15:0];

                endcase

                d_loadresult[31:16] = {16{d_loadresult[15] & load_sign_ext}};
              end

          default: d_loadresult = d_readdatain;

        endcase

      end
endmodule

