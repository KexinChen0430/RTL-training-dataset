
module input_pipeline(clk,clk_ena,in_stream,pipeline_reg_0,pipeline_reg_1,
                      pipeline_reg_17,reset);

  parameter  WIDTH = 1;
  input  clk;
  input  clk_ena;
  input  [(-1)+WIDTH:0] in_stream;
  output [(-1)+WIDTH:0] pipeline_reg_0;
  output [(-1)+WIDTH:0] pipeline_reg_17;
  input  reset;
  reg  [(-1)+WIDTH:0] pipeline_reg_0;
  reg  [(-1)+WIDTH:0] pipeline_reg_17;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            pipeline_reg_0 <= 0;
            pipeline_reg_17 <= 0;
          end
        else 
          begin
            if (clk_ena) 
              begin
                pipeline_reg_0 <= in_stream;
                pipeline_reg_1 <= pipeline_reg_0;
                pipeline_reg_17 <= pipeline_reg_16;
              end
              
          end
      end
endmodule

