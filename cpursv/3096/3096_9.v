
module SIPO(data_out,out_valid,serial_in,in_valid,reset_b,clk);

  output [7:0] data_out;
  output out_valid;
  input  serial_in;
  input  clk;
  input  reset_b;
  input  in_valid;
  reg  out_valid;
  reg  [7:0] data_out;
  reg  [7:0] q_dff;
  reg  flag1,flag2,flag3,flag4,flag5,flag6,flag7,flag8;

  
  always @(negedge reset_b)
      begin
        out_valid <= 1'b0;
        data_out <= 8'd0;
        q_dff <= 8'd0;
        flag1 <= 1'b1;
        flag2 <= 1'b1;
        flag3 <= 1'b1;
        flag4 <= 1'b1;
        flag5 <= 1'b1;
        flag6 <= 1'b1;
        flag7 <= 1'b1;
        flag8 <= 1'b1;
      end
  
  always @(posedge clk)
      begin
        if (in_valid && ~out_valid && reset_b) 
          begin
            if (flag1) 
              begin
                $display($time,"Process input #1",serial_in);
                q_dff[0] <= serial_in;
                flag1 <= 1'b0;
              end
              
          end
          
      end
  
  always @(posedge clk)
      begin
        if (in_valid && ~out_valid && reset_b) 
          begin
            if (~flag1 && flag2) 
              begin
                $display($time,"Process input #2",serial_in);
                q_dff[1] <= serial_in;
                flag2 <= 1'b0;
              end
              
          end
          
      end
  
  always @(posedge clk)
      begin
        if (in_valid && ~out_valid && reset_b) 
          begin
            if (flag8 && ~flag7) 
              begin
                $display($time,"Process input #8",serial_in);
                q_dff[7] <= serial_in;
                flag8 <= 1'b0;
                out_valid <= 1'b1;
              end
              
          end
        else if (out_valid) 
          begin
            $display($time,"Produce the output and reset data",
                     serial_in);
            data_out <= q_dff;
            flag1 <= 1'b1;
            flag2 <= 1'b1;
            flag3 <= 1'b1;
            flag4 <= 1'b1;
            flag5 <= 1'b1;
            flag6 <= 1'b1;
            flag7 <= 1'b1;
            flag8 <= 1'b1;
            out_valid <= 1'b0;
            q_dff <= 8'd0;
          end
          
      end
endmodule

