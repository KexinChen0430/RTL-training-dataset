
module para2ser(input  clk,
                input  rst_n,
                input  trans_start,
                input  [8:0] data,
                input  [3:0] data_len,
                output wire output_data,
                output wire output_start,
                output wire output_done);

  reg  [3:0] data_cnt;
  reg  [8:0] data_reg;

  
  always @(posedge clk or negedge rst_n)
      begin
        if (~rst_n) 
          begin
            data_cnt <= 4'b0;
            data_reg <= 9'b0;
          end
        else if (trans_start) 
          begin
            data_cnt <= (data_cnt == 4'b0) ? ((-1)+data_len) : (data_cnt+(-1));
            data_reg <= data;
          end
          
      end
  reg  trans_start_q1;

  reg  trans_start_q2;

  
  always @(posedge clk or negedge rst_n)
      begin
        if (~rst_n) 
          begin
            trans_start_q1 <= 1'b0;
            trans_start_q2 <= 1'b0;
          end
        else 
          begin
            trans_start_q1 <= trans_start;
            trans_start_q2 <= trans_start_q1;
          end
      end
  assign output_start = trans_start & ~trans_start_q1;
  assign output_done = trans_start_q2 & ~trans_start_q1;
  assign output_data = 1'b1 & data_reg>>data_cnt;
endmodule

