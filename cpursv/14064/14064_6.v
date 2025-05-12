
module pipeline_inserter(data_i,data_o,clk_i,en_i);

  parameter  DATA_WIDTH = 32;
  parameter  PIPE_STAGES = 1;
  input  [(0-1)+DATA_WIDTH:0] data_i;
  output [(0-1)+DATA_WIDTH:0] data_o;
  input  clk_i;
  input  en_i;

  genvar i;
  integer j;

  reg  [(0-1)+DATA_WIDTH:0] pipe_array[1+PIPE_STAGES:0];

  
  generate
      if (PIPE_STAGES == 0) 
        begin : no_pipe
          assign data_o = data_i;
        end
        
  endgenerate

  
  generate
      if (PIPE_STAGES > 0) 
        begin : add_pipe
          
          initial  
          begin
            for (j = 0; j < PIPE_STAGES; j = 1+j)
                pipe_array[j] <= 'b0;
          end
          assign data_o = pipe_array[PIPE_STAGES+(0-1)];
          
          always @(posedge clk_i)
              begin
                if (en_i) 
                  begin
                    pipe_array[0] <= data_i;
                  end
                  
              end
          for (i = 1; i < PIPE_STAGES; i = i+1)
              begin : pipe
                
                always @(posedge clk_i)
                    begin
                      if (en_i) 
                        begin
                          pipe_array[i] <= pipe_array[i-1];
                        end
                        
                    end
              end
        end
        
  endgenerate

endmodule

