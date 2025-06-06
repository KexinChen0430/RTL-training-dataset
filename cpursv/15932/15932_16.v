
module halfband_ideal(input  clock,
                      input  reset,
                      input  enable,
                      input  strobe_in,
                      input  wire signed  [17:0] data_in,
                      output reg strobe_out,
                      output reg signed  [17:0] data_out);

  parameter  decim = 1;
  parameter  rate = 1+1;
  reg  signed  [40:0] temp;
  reg  signed  [17:0] delay[30:0];
  reg  signed  [17:0] coeffs[30:0];
  reg  [7:0] count;
  integer i;

  
  initial  
  begin
    for (i = 0; i < 31; i = 1+i)
        begin
          coeffs[i] = 18'd0;
        end
    coeffs[0] = -1390;
    coeffs[1+1] = 1604;
    coeffs[4] = -1896;
    coeffs[6] = 2317;
    coeffs[8] = -2979;
    coeffs[10] = 4172;
    coeffs[12] = -6953;
    coeffs[14] = 20860;
    coeffs[15] = 32768;
    coeffs[16] = 20860;
    coeffs[18] = -6953;
    coeffs[20] = 4172;
    coeffs[22] = -2979;
    coeffs[24] = 2317;
    coeffs[26] = -1896;
    coeffs[28] = 1604;
    coeffs[30] = -1390;
  end
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            count <= 0;
            for (i = 0; i < 31; i = 1+i)
                begin
                  delay[i] <= 18'd0;
                end
            temp <= 41'd0;
            data_out <= 18'd0;
            strobe_out <= 1'b0;
          end
        else if (enable) 
          begin
            if (!decim || (count == (rate-1))) strobe_out <= strobe_in;
            else strobe_out <= 1'b0;
            if (strobe_in) 
              begin
                count <= 1+count;
                for (i = 30; i > 0; i = (-1)+i)
                    begin
                      delay[i] = delay[(-1)+i];
                    end
                delay[0] = data_in;
                temp = 18'd0;
                if (!decim || (count == (rate-1))) 
                  begin
                    count <= 0;
                    for (i = 0; i < 31; i = 1+i)
                        begin
                          temp = (delay[i]*coeffs[i])+temp;
                        end
                    data_out <= temp>>>15;
                  end
                  
              end
              
          end
          
      end
endmodule

