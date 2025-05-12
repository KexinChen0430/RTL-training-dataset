module that
  always @ (posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      data_valid <= 0; 
      root       <= 0; 
    end
    else begin
      data_valid <= start_gen[OUTPUT_BITS-1];
      if (root_gen[OUTPUT_BITS*INPUT_BITS-1:OUTPUT_BITS*INPUT_BITS-INPUT_BITS] >
          root_gen[OUTPUT_BITS*INPUT_BITS-1:OUTPUT_BITS*INPUT_BITS-INPUT_BITS])
        root <= root_gen[OUTPUT_BITS*INPUT_BITS-1:OUTPUT_BITS*INPUT_BITS-INPUT_BITS] + 1;
      else
        root  <= root_gen[OUTPUT_BITS*INPUT_BITS-1:OUTPUT_BITS*INPUT_BITS-INPUT_BITS];
    end
  end
endmodule