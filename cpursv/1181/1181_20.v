
module arriaiigz_saturate_block(datain,saturate,round,signa,signb,datain_width,dataout,
                                saturation_overflow);

  parameter  dataa_width = 36;
  parameter  datab_width = 36;
  parameter  round_width = 15;
  parameter  saturate_width = 1;
  parameter  accum_width = dataa_width+8;
  parameter  saturate_mode = asymmetric;
  parameter  operation_mode = output_only;
  input  [71:0] datain;
  input  saturate;
  input  round;
  input  signa;
  input  signb;
  input  [7:0] datain_width;
  output [71:0] dataout;
  output saturation_overflow;
  reg  [71:0] dataout_tmp;
  reg  saturation_overflow_tmp;
  wire msb;
  wire sign;
  integer i;
  reg  [71:0] max;
  reg  [71:0] min;
  reg  sign_tmp;
  reg  data_tmp;

  
  initial  
  begin
    max = {72{1'b0}};
    min = {72{1'b1}};
    sign_tmp = 1'b1;
    data_tmp = 1'b0;
  end
  assign sign = signb | signa;
  assign msb = ((operation_mode == accumulator_chain_out) || 
               (operation_mode == two_level_adder_chain_out) || (operation_mode == accumulator)) ? datain[accum_width] : 
               (operation_mode == two_level_adder) ? datain[dataa_width+1] : 
               ((operation_mode == loopback) || 
               (operation_mode == one_level_adder)) ? datain[dataa_width] : datain[dataa_width-1];
  assign dataout = dataout_tmp;
  assign saturation_overflow = saturation_overflow_tmp;
  
  always @(datain or datain_width or sign or round or msb or saturate)
      begin
        if (saturate == 1'b0) 
          begin
            dataout_tmp = datain;
            saturation_overflow_tmp = 1'b0;
          end
        else 
          begin
            saturation_overflow_tmp = 1'b0;
            data_tmp = 1'b0;
            sign_tmp = 1'b1;
            if (round == 1'b1) 
              begin
                for (i = 0; i < (datain_width-round_width); i = i+1)
                    begin
                      min[i] = 1'bX;
                      max[i] = 1'bX;
                    end
              end
              
            if (saturate_mode == symmetric) 
              begin
                for (i = 0; i < (datain_width-round_width); i = i+1)
                    begin
                      if (round == 1'b1) 
                        begin
                          max[i] = 1'bX;
                          min[i] = 1'bX;
                        end
                      else 
                        begin
                          max[i] = 1'b1;
                          min[i] = 1'b0;
                        end
                    end
                for (i = datain_width-round_width; i < (datain_width-saturate_width); i = i+1)
                    begin
                      data_tmp = data_tmp | datain[i];
                      max[i] = 1'b1;
                      min[i] = 1'b0;
                    end
                if (round == 1'b1) 
                  begin
                    min[datain_width-round_width] = 1'b1;
                  end
                else 
                  begin
                    min[0] = 1'b1;
                  end
              end
              
            if (saturate_mode == asymmetric) 
              begin
                for (i = 0; i < (datain_width-saturate_width); i = i+1)
                    begin
                      max[i] = 1'b1;
                      min[i] = 1'b0;
                    end
              end
              
            if (saturate_width == 1) 
              begin
                if (msb != datain[datain_width-1]) 
                  begin
                    saturation_overflow_tmp = 1'b1;
                  end
                else 
                  begin
                    sign_tmp = sign_tmp & datain[datain_width-1];
                  end
              end
            else 
              begin
                for (i = datain_width-saturate_width; i < datain_width; i = i+1)
                    begin
                      sign_tmp = sign_tmp & datain[i];
                      if (datain[datain_width-1] != datain[i]) 
                        begin
                          saturation_overflow_tmp = 1'b1;
                        end
                        
                    end
              end
            if ((data_tmp == 1'b0) && (sign_tmp == 1'b1) && 
                (saturate_mode == symmetric)) 
              begin
                saturation_overflow_tmp = 1'b1;
              end
              
            if (saturation_overflow_tmp) 
              begin
                if ((operation_mode == output_only) || 
                    ((operation_mode == accumulator_chain_out) || 
(operation_mode == two_level_adder_chain_out))) 
                  begin
                    if (msb) 
                      begin
                        dataout_tmp = min;
                      end
                    else 
                      begin
                        dataout_tmp = max;
                      end
                  end
                else 
                  begin
                    if (sign) 
                      begin
                        if (msb) 
                          begin
                            dataout_tmp = min;
                          end
                        else 
                          begin
                            dataout_tmp = max;
                          end
                      end
                    else 
                      begin
                        dataout_tmp = 72'bX;
                      end
                  end
              end
            else 
              begin
                dataout_tmp = datain;
              end
          end
      end
endmodule

