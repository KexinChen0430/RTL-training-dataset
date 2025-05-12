
module oh_iobuf  #(parameter  N = 1, TYPE = BEHAVIORAL)
  (inout  vdd,
   inout  vddio,
   inout  vss,
   input  enpullup,
   input  enpulldown,
   input  slewlimit,
   input  [3:0] drivestrength,
   input  [(0-1)+N:0] ie,
   input  [(0-1)+N:0] oe,
   output [(0-1)+N:0] out,
   input  [(0-1)+N:0] in,
   inout  [(0-1)+N:0] pad);

  genvar i;
  for (i = 0; i < N; i = 1+i)
      begin : gen_buf
        if (TYPE == BEHAVIORAL) 
          begin : gen_beh
            assign pad[i] = oe[i] ? in[i] : 1'bZ;
            assign out[i] = ie[i] ? pad[i] : 1'b0;
          end
        else 
          begin : gen_custom

          end
      end
endmodule

