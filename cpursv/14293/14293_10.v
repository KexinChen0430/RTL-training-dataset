
module XC2COrArray(pterms_in,config_bits,or_out);

  input  wire [55:0] pterms_in;
  input  wire [(56*16)+(0-1):0] config_bits;
  output reg [15:0] or_out;
  integer nout;
  integer nterm;
  reg  [55:0] or_config[15:0];

  
  always @(*)
      begin
        for (nterm = 0; nterm < 56; nterm = nterm+1)
            begin
              for (nout = 0; nout < 16; nout = 1+nout)
                  or_config[nout][nterm] <= config_bits[nterm+(nout*56)];
            end
      end
  
  always @(*)
      begin
        for (nout = 0; nout < 16; nout = 1+nout)
            begin
              or_out[nout] = 0;
              for (nterm = 0; nterm < 56; nterm = nterm+1)
                  begin
                    if (!or_config[nout][nterm]) or_out[nout] = or_out[nout] | pterms_in[nterm];
                      
                  end
            end
      end
endmodule

