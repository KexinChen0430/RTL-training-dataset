
module ac97(output reg ready,
            input  wire [7:0] command_address,
            input  wire [15:0] command_data,
            input  wire command_valid,
            input  wire [19:0] left_data,
            input  wire left_valid,
            input  wire [19:0] right_data,
            input  wire right_valid,
            output reg [19:0] left_in_data,
            output reg [19:0] right_in_data,
            output reg ac97_sdata_out,
            input  wire ac97_sdata_in,
            output reg ac97_synch,
            input  wire ac97_bit_clock);

  reg  [7:0] bit_count;
  reg  [19:0] l_cmd_addr;
  reg  [19:0] l_cmd_data;
  reg  [19:0] l_left_data,l_right_data;
  reg  l_cmd_v,l_left_v,l_right_v;

  
  initial  
  begin
    ready <= 1'b0;
    ac97_sdata_out <= 1'b0;
    ac97_synch <= 1'b0;
    bit_count <= 8'h00;
    l_cmd_v <= 1'b0;
    l_left_v <= 1'b0;
    l_right_v <= 1'b0;
    left_in_data <= 20'h00000;
    right_in_data <= 20'h00000;
  end
  
  always @(posedge ac97_bit_clock)
      begin
        if (bit_count == 255) ac97_synch <= 1'b1;
          
        if (bit_count == 15) ac97_synch <= 1'b0;
          
        if (bit_count == 128) ready <= 1'b1;
          
        if (bit_count == (1+1)) ready <= 1'b0;
          
        if (bit_count == 255) 
          begin
            l_cmd_addr <= {command_address,12'h000};
            l_cmd_data <= {command_data,4'h0};
            l_cmd_v <= command_valid;
            l_left_data <= left_data;
            l_left_v <= left_valid;
            l_right_data <= right_data;
            l_right_v <= right_valid;
          end
          
        if ((bit_count >= 0) && (bit_count <= 15)) 
          case (bit_count[3:0])

            4'h0: ac97_sdata_out <= 1'b1;

            4'h1: ac97_sdata_out <= l_cmd_v;

            4'h2: ac97_sdata_out <= l_cmd_v;

            4'h3: ac97_sdata_out <= l_left_v;

            4'h4: ac97_sdata_out <= l_right_v;

            default: ac97_sdata_out <= 1'b0;

          endcase

        else if ((bit_count >= 16) && (bit_count <= 35)) ac97_sdata_out <= l_cmd_v ? l_cmd_addr[35-bit_count] : 1'b0;
        else if ((bit_count >= 36) && (bit_count <= 55)) 
          ac97_sdata_out <= l_cmd_v ? l_cmd_data[55+(0-bit_count)] : 1'b0;
        else if ((bit_count >= 56) && (bit_count <= 75)) 
          begin
            ac97_sdata_out <= l_left_v ? l_left_data[19] : 1'b0;
            l_left_data <= {l_left_data[18:0],l_left_data[19]};
          end
        else if ((bit_count >= 76) && (bit_count <= 95)) 
          ac97_sdata_out <= l_right_v ? l_right_data[95+(0-bit_count)] : 1'b0;
        else ac97_sdata_out <= 1'b0;
        bit_count <= 1+bit_count;
      end
  
  always @(negedge ac97_bit_clock)
      begin
        if ((bit_count >= 57) && (bit_count <= 76)) left_in_data <= {left_in_data[18:0],ac97_sdata_in};
        else if ((bit_count <= 96) && (bit_count >= 77)) right_in_data <= {right_in_data[18:0],ac97_sdata_in};
          
      end
endmodule

