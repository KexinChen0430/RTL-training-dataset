module "padder1" */
    reg [63:0] v1;          
    wire accept, update;    
    assign buffer_full = i[8]; 
    assign out_ready = buffer_full; 
    assign accept = (~ state) & in_ready & (~ buffer_full); 
    assign update = (accept | (state & (~ buffer_full))) & (~ done); 
    always @ (posedge clk)
      if (reset)
        out <= 0;
      else if (update)
        out <= {out[575-64:0], v1};
    always @ (posedge clk)
      if (reset)
        i <= 0;
      else if (f_ack | update)
        i <= {i[7:0], 1'b1} & {9{~ f_ack}};
    always @ (posedge clk)
      if (reset)
        state <= 0;
      else if (is_last)
        state <= 1;
    always @ (posedge clk)
      if (reset)
        done <= 0;
      else if (state & out_ready)
        done <= 1;
    padder1 p0 (in, byte_num, v0);
    always @ (*)
      begin
        if (state)
          begin
            v1 = 0;
            v1[7] = v1[7] | i[7]; 
          end
        else if (is_last == 0)
          v1 = in;
        else
          begin
            v1 = v0;
            v1[7] = v1[7] | i[7];
          end
      end
endmodule