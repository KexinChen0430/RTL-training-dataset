
module real_main;

  integer file_count;
  reg  [15:0] timer;
  reg  [1:0] program_counter;
  reg  [15:0] address_2;
  reg  [15:0] data_out_2;
  reg  [15:0] data_in_2;
  reg  write_enable_2;
  reg  [15:0] address_4;
  reg  [31:0] data_out_4;
  reg  [31:0] data_in_4;
  reg  write_enable_4;
  reg  [15:0] register_0;
  reg  clk;
  reg  rst;

  
  initial  
  begin
    rst <= 1'b1;
    #50 rst <= 1'b0;
  end
  
  initial  
  begin
    clk <= 1'b0;
    while (1)
      begin
        #5 clk <= ~clk;
      end
  end
  
  always @(posedge clk)
      begin
        timer <= 16'h0000;
        case (program_counter)

          16'd0: begin
                program_counter <= 16'd1;
                program_counter <= 16'd3;
                register_0 <= 16'd1;
              end

          16'd1: begin
                program_counter <= 16'd3;
                $finish;
                program_counter <= program_counter;
              end

          16'd3: begin
                program_counter <= 16'd2;
                program_counter <= register_0;
              end

        endcase

        if (rst == 1'b1) 
          begin
            program_counter <= 0;
          end
          
      end
endmodule

