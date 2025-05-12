
module input_pipeline(clk,clk_ena,in_stream,pipeline_reg_0,pipeline_reg_1,
                      pipeline_reg_2,pipeline_reg_3,pipeline_reg_4,pipeline_reg_5,
                      pipeline_reg_6,pipeline_reg_7,pipeline_reg_8,pipeline_reg_9,
                      pipeline_reg_10,pipeline_reg_11,pipeline_reg_12,
                      pipeline_reg_13,reset);

  parameter  WIDTH = 1;
  input  clk;
  input  clk_ena;
  input  [(-1)+WIDTH:0] in_stream;
  output [(-1)+WIDTH:0] pipeline_reg_0;
  output [(-1)+WIDTH:0] pipeline_reg_1;
  output [(-1)+WIDTH:0] pipeline_reg_2;
  output [(-1)+WIDTH:0] pipeline_reg_3;
  output [(-1)+WIDTH:0] pipeline_reg_4;
  output [(-1)+WIDTH:0] pipeline_reg_5;
  output [(-1)+WIDTH:0] pipeline_reg_6;
  output [(-1)+WIDTH:0] pipeline_reg_7;
  output [(-1)+WIDTH:0] pipeline_reg_8;
  output [(-1)+WIDTH:0] pipeline_reg_9;
  output [(-1)+WIDTH:0] pipeline_reg_10;
  output [(-1)+WIDTH:0] pipeline_reg_11;
  output [(-1)+WIDTH:0] pipeline_reg_12;
  output [(-1)+WIDTH:0] pipeline_reg_13;
  reg  [(-1)+WIDTH:0] pipeline_reg_0;
  reg  [(-1)+WIDTH:0] pipeline_reg_1;
  reg  [(-1)+WIDTH:0] pipeline_reg_2;
  reg  [(-1)+WIDTH:0] pipeline_reg_3;
  reg  [(-1)+WIDTH:0] pipeline_reg_4;
  reg  [(-1)+WIDTH:0] pipeline_reg_5;
  reg  [(-1)+WIDTH:0] pipeline_reg_6;
  reg  [(-1)+WIDTH:0] pipeline_reg_7;
  reg  [(-1)+WIDTH:0] pipeline_reg_8;
  reg  [(-1)+WIDTH:0] pipeline_reg_9;
  reg  [(-1)+WIDTH:0] pipeline_reg_10;
  reg  [(-1)+WIDTH:0] pipeline_reg_11;
  reg  [(-1)+WIDTH:0] pipeline_reg_12;
  reg  [(-1)+WIDTH:0] pipeline_reg_13;
  input  reset;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            pipeline_reg_0 <= 0;
            pipeline_reg_1 <= 0;
            pipeline_reg_2 <= 0;
            pipeline_reg_3 <= 0;
            pipeline_reg_4 <= 0;
            pipeline_reg_5 <= 0;
            pipeline_reg_6 <= 0;
            pipeline_reg_7 <= 0;
            pipeline_reg_8 <= 0;
            pipeline_reg_9 <= 0;
            pipeline_reg_10 <= 0;
            pipeline_reg_11 <= 0;
            pipeline_reg_12 <= 0;
            pipeline_reg_13 <= 0;
          end
        else 
          begin
            if (clk_ena) 
              begin
                pipeline_reg_0 <= in_stream;
                pipeline_reg_1 <= pipeline_reg_0;
                pipeline_reg_2 <= pipeline_reg_1;
                pipeline_reg_3 <= pipeline_reg_2;
                pipeline_reg_4 <= pipeline_reg_3;
                pipeline_reg_5 <= pipeline_reg_4;
                pipeline_reg_6 <= pipeline_reg_5;
                pipeline_reg_7 <= pipeline_reg_6;
                pipeline_reg_8 <= pipeline_reg_7;
                pipeline_reg_9 <= pipeline_reg_8;
                pipeline_reg_10 <= pipeline_reg_9;
                pipeline_reg_11 <= pipeline_reg_10;
                pipeline_reg_12 <= pipeline_reg_11;
                pipeline_reg_13 <= pipeline_reg_12;
              end
              
          end
      end
endmodule

