
module cic_dec_3  #(parameter 
       NUM_STAGES = 4,
       STG_GSZ    = 8,
       ISZ        = 10,
       ASZ        = (STG_GSZ*NUM_STAGES)+ISZ,
       OSZ        = ASZ)
  (input  clk,
   input  reset,
   input  ena_out,
   input  signed  [ISZ-1:0] x,
   output signed  [OSZ-1:0] y,
   output valid);

  wire signed  [(0-1)+ASZ:0]  x_sx = {{ASZ+(0-ISZ){x[ISZ-1]}},x};
  reg  signed  [(0-1)+ASZ:0] integrator[0:NUM_STAGES-1];

  
  always @(posedge clk)
      begin
        if (reset == 1'b1) 
          begin
            integrator[0] <= {ASZ{1'b0}};
          end
        else 
          begin
            integrator[0] <= integrator[0]+x_sx;
          end
      end
  
  generate
      genvar i;
      for (i = 1; i < NUM_STAGES; i = 1+i)
          begin
            
            always @(posedge clk)
                begin
                  if (reset == 1'b1) 
                    begin
                      integrator[i] <= {ASZ{1'b0}};
                    end
                  else 
                    begin
                      integrator[i] <= integrator[i]+integrator[i-1];
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
            comb_ena <= {(1+NUM_STAGES)+1{1'b0}};
            comb_diff[0] <= {OSZ{1'b0}};
            comb_dly[0] <= {OSZ{1'b0}};
          end
        else 
          begin
            if (ena_out == 1'b1) 
              begin
                comb_diff[0] <= integrator[NUM_STAGES-1]>>>ASZ-OSZ;
                comb_dly[0] <= comb_diff[0];
              end
              
            comb_ena <= {comb_ena[NUM_STAGES:0],ena_out};
          end
      end
  
  generate
      genvar j;
      for (j = 1; j <= NUM_STAGES; j = j+1)
          begin
            
            always @(posedge clk)
                begin
                  if (reset == 1'b1) 
                    begin
                      comb_diff[j] <= {OSZ{1'b0}};
                      comb_dly[j] <= {OSZ{1'b0}};
                    end
                  else if (comb_ena[(0-1)+j] == 1'b1) 
                    begin
                      comb_diff[j] <= comb_diff[(0-1)+j]+(-comb_dly[(0-1)+j]);
                      comb_dly[j] <= comb_diff[j];
                    end
                    
                end
          end
  endgenerate

  assign y = comb_diff[NUM_STAGES];
  assign valid = comb_ena[NUM_STAGES];
endmodule

