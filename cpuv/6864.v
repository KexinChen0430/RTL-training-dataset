module arbiter(input_a,input_b,input_a_stb,input_b_stb,output_z_ack,clk,rst,output_z,output_z_stb,input_a_ack,input_b_ack);
  integer file_count; 
  input     [15:0] input_a; 
  input     [15:0] input_b; 
  input     input_a_stb; 
  input     input_b_stb; 
  input     output_z_ack; 
  input     clk; 
  input     rst; 
  output    [15:0] output_z; 
  output    output_z_stb; 
  output    input_a_ack; 
  output    input_b_ack; 
  reg       [15:0] timer; 
  reg       [3:0] program_counter; 
  reg       [15:0] address_2; 
  reg       [15:0] data_out_2; 
  reg       [15:0] data_in_2; 
  reg       write_enable_2; 
  reg       [15:0] address_4; 
  reg       [31:0] data_out_4; 
  reg       [31:0] data_in_4; 
  reg       write_enable_4; 
  reg       [15:0] register_0; 
  reg       [15:0] register_1; 
  reg       [15:0] s_output_z_stb; 
  reg       [15:0] s_output_z; 
  reg       [15:0] s_input_a_ack; 
  reg       [15:0] s_input_b_ack; 
  always @(posedge clk) 
  begin
    timer <= 16'h0000; 
    case(program_counter) 
      16'd0: 
      begin
        program_counter <= 16'd1; 
        program_counter <= 16'd3; 
        register_0 <= 16'd1; 
      end
      16'd1: 
      begin
        program_counter <= 16'd3; 
        program_counter <= program_counter; 
      end
      16'd3: 
      begin
        program_counter <= 16'd2; 
        register_1 <= 0; 
        register_1[0] <= input_a_stb; 
      end
      16'd2: 
      begin
        program_counter <= 16'd6; 
        if (register_1 == 0) 
          program_counter <= 4; 
      end
      16'd6: 
      begin
        program_counter <= 16'd7; 
        register_1 <= input_a; 
        program_counter <= 6; 
        s_input_a_ack <= 1'b1; 
       if (s_input_a_ack == 1'b1 && input_a_stb == 1'b1) begin 
          s_input_a_ack <= 1'b0; 
          program_counter <= 16'd7; 
        end
      end
      16'd7: 
      begin
        program_counter <= 16'd5; 
        s_output_z <= register_1; 
        program_counter <= 7; 
        s_output_z_stb <= 1'b1; 
        if (s_output_z_stb == 1'b1 && output_z_ack == 1'b1) begin 
          s_output_z_stb <= 1'b0; 
          program_counter <= 5; 
        end
      end
      16'd5: 
      begin
        program_counter <= 16'd4; 
        program_counter <= 16'd4; 
      end
      16'd4: 
      begin
        program_counter <= 16'd12; 
        register_1 <= 0; 
        register_1[0] <= input_b_stb; 
      end
      16'd12: 
      begin
        program_counter <= 16'd13; 
        if (register_1 == 0) 
          program_counter <= 10; 
      end
      16'd13: 
      begin
        program_counter <= 16'd15; 
        register_1 <= input_b; 
        program_counter <= 13; 
        s_input_b_ack <= 1'b1; 
       if (s_input_b_ack == 1'b1 && input_b_stb == 1'b1) begin 
          s_input_b_ack <= 1'b0; 
          program_counter <= 16'd15; 
        end
      end
      16'd15: 
      begin
        program_counter <= 16'd14; 
        s_output_z <= register_1; 
        program_counter <= 15; 
        s_output_z_stb <= 1'b1; 
        if (s_output_z_stb == 1'b1 && output_z_ack == 1'b1) begin 
          s_output_z_stb <= 1'b0; 
          program_counter <= 14; 
        end
      end
      16'd14: 
      begin
        program_counter <= 16'd10; 
        program_counter <= 16'd10; 
      end
      16'd10: 
      begin
        program_counter <= 16'd11; 
        program_counter <= 16'd3; 
      end
      16'd11: 
      begin
        program_counter <= 16'd9; 
        program_counter <= register_0; 
      end
    endcase
    if (rst == 1'b1) begin 
      program_counter <= 0; 
      s_input_a_ack <= 0; 
      s_input_b_ack <= 0; 
      s_output_z_stb <= 0; 
    end
  end
  assign input_a_ack = s_input_a_ack; 
  assign input_b_ack = s_input_b_ack; 
  assign output_z_stb = s_output_z_stb; 
  assign output_z = s_output_z; 
endmodule