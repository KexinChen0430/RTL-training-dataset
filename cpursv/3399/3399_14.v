
module cic_dec_2  #(parameter 
       NUM_STAGES = 4,
       STG_GSZ    = 8,
       ISZ        = 10,
       OSZ        = ISZ+(NUM_STAGES*STG_GSZ))
  (input  clk,
   input  reset,
   input  ena_out,
   input  signed  [ISZ-1:0] x,
   output signed  [OSZ-1:0] y,
   output valid);

  wire signed  [OSZ-1:0]  x_sx = {{(-ISZ)+OSZ{x[ISZ-1]}},x};
  reg  signed  [OSZ-1:0] integrator[0:NUM_STAGES-1];

  
  always @(posedge clk)
      begin
        if (reset == 1'b1) 
          begin
            integrator[0] <= {OSZ{1'b0}};
          end
        else 
          begin
            integrator[0] <= integrator[0]+x_sx;
          end
      end
  
  generate
      genvar i;
      for (i = 1; i < NUM_STAGES; i = i+1)
          begin
            
            always @(posedge clk)
                begin
                  if (reset == 1'b1) 
                    begin
                      integrator[i] <= {OSZ{1'b0}};
                    end
                  else 
                    begin
                      integrator[i] <= integrator[i]+integrator[(0-1)+i];
                    end
                end
          end
  endgenerate

  reg  [NUM_STAGES:0] comb_ena;

  reg  signed  [OSZ-1:0] comb_diff[0:NUM_STAGES];

  reg  signed  [OSZ-1:0] comb_dly[0:NUM_STAGES];

  
  always @(posedge clk)
      begin
        if (reset == 1'b1) 
          begin
            comb_ena <= {1+(1+NUM_STAGES){1'b0}};
            comb_diff[0] <= {OSZ{1'b0}};
            comb_dly[0] <= {OSZ{1'b0}};
          end
        else 
          begin
            if (ena_out == 1'b1) 
              begin
                comb_diff[0] <= integrator[NUM_STAGES-1];
                comb_dly[0] <= comb_diff[0];
              end
              
            comb_ena <= {comb_ena[NUM_STAGES:0],ena_out};
          end
      end
  
  generate
      genvar j;
      for (j = 1; j <= NUM_STAGES; j = 1+j)
          begin
            
            always @(posedge clk)
                begin
                  if (reset == 1'b1) 
                    begin
                      comb_diff[j] <= {OSZ{1'b0}};
                      comb_dly[j] <= {OSZ{1'b0}};
                    end
                  else if (comb_ena[j-1] == 1'b1) 
                    begin
                      comb_diff[j] <= (0-comb_dly[j-1])+comb_diff[j-1];
                      comb_dly[j] <= comb_diff[j];
                    end
                    
                end
          end
  endgenerate

  assign y = comb_diff[NUM_STAGES];
  assign valid = comb_ena[NUM_STAGES];
endmodule

