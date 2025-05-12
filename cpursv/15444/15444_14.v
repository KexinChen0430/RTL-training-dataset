
module PISO(serial_out,out_valid,data_in,load,reset_b,clk);

  output serial_out;
  output out_valid;
  input  [7:0] data_in;
  input  clk;
  input  reset_b;
  input  load;
  reg  out_valid;
  reg  serial_out;
  reg  q_dff1,q_dff2,q_dff3,q_dff4,q_dff5,q_dff6,q_dff7;
  reg  flag2,flag3,flag4,flag5,flag6,flag7;

  
  always @(negedge reset_b)
      begin
        out_valid <= 1'b0;
        serial_out <= 1'b0;
        q_dff1 <= 1'b0;
        q_dff2 <= 1'b0;
        q_dff3 <= 1'b0;
        q_dff4 <= 1'b0;
        q_dff5 <= 1'b0;
        q_dff6 <= 1'b0;
        q_dff7 <= 1'b0;
        flag2 <= 1'b1;
        flag3 <= 1'b1;
        flag4 <= 1'b1;
        flag5 <= 1'b1;
        flag6 <= 1'b1;
        flag7 <= 1'b1;
      end
  
  always @(posedge clk)
      begin
        if (!out_valid && (reset_b && load)) 
          begin
            q_dff1 <= data_in[7];
          end
        else 
          begin
            q_dff1 <= 1'bx;
          end
      end
  
  always @(posedge clk)
      begin
        if (!out_valid && (reset_b && load)) 
          begin
            q_dff2 <= data_in[6];
          end
        else if (out_valid) 
          begin
            q_dff2 <= q_dff1;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (!out_valid && (reset_b && load)) 
          begin
            q_dff3 <= data_in[5];
          end
        else if (out_valid) 
          begin
            q_dff3 <= q_dff2;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (!out_valid && (reset_b && load)) 
          begin
            q_dff4 <= data_in[4];
          end
        else if (out_valid) 
          begin
            q_dff4 <= q_dff3;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (!out_valid && (reset_b && load)) 
          begin
            q_dff5 <= data_in[3];
          end
        else if (out_valid) 
          begin
            q_dff5 <= q_dff4;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (!out_valid && (reset_b && load)) 
          begin
            q_dff6 <= data_in[2];
          end
        else if (out_valid) 
          begin
            q_dff6 <= q_dff5;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (!out_valid && (reset_b && load)) 
          begin
            q_dff7 <= data_in[1];
          end
        else if (out_valid) 
          begin
            q_dff7 <= q_dff6;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (!out_valid && (reset_b && load)) 
          begin
            serial_out <= data_in[0];
            out_valid <= 1'b1;
          end
        else if ((q_dff7 !== 1'bz) && ((q_dff7 !== 1'bx) && out_valid)) 
          begin
            serial_out <= q_dff7;
          end
        else 
          begin
            out_valid <= 1'b0;
            serial_out <= 1'b0;
          end
      end
endmodule

