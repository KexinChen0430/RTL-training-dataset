
module reg_16bit(clk,Load,not_reset,D,Q);

  input  wire clk;
  input  wire not_reset;
  input  wire Load;
  input  wire [15:0] D;
  output wire [15:0] Q;
  reg  [15:0] Q_ALTERA_SYNTHESIZED;

  
  always @(posedge clk or negedge not_reset)
      begin
        if (!not_reset) 
          begin
            Q_ALTERA_SYNTHESIZED[15] <= 0;
          end
        else if (Load) 
          begin
            Q_ALTERA_SYNTHESIZED[15] <= D[15];
          end
          
      end
  
  always @(posedge clk or negedge not_reset)
      begin
        if (!not_reset) 
          begin
            Q_ALTERA_SYNTHESIZED[5] <= 0;
          end
        else if (Load) 
          begin
            Q_ALTERA_SYNTHESIZED[5] <= D[5];
          end
          
      end
  
  always @(posedge clk or negedge not_reset)
      begin
        if (!not_reset) 
          begin
            Q_ALTERA_SYNTHESIZED[0] <= 0;
          end
        else if (Load) 
          begin
            Q_ALTERA_SYNTHESIZED[0] <= D[0];
          end
          
      end
  assign Q = Q_ALTERA_SYNTHESIZED;
endmodule

