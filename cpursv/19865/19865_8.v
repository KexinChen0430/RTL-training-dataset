
module cpu_behavioral(cpu_rst_i,cpu_clk_o,cpu_addr_i,cpu_data_o,cpu_data_i,
                      cpu_bp_o,cpu_stall_i,cpu_stb_i,cpu_we_i,cpu_ack_o,cpu_rst_o);

  input  cpu_rst_i;
  output cpu_clk_o;
  input  [31:0] cpu_addr_i;
  output [31:0] cpu_data_o;
  input  [31:0] cpu_data_i;
  output cpu_bp_o;
  input  cpu_stall_i;
  input  cpu_stb_i;
  input  cpu_we_i;
  output cpu_ack_o;
  output cpu_rst_o;
  reg  cpu_clk_o;
  reg  [31:0] cpu_data_o;
  reg  cpu_bp_o;
  reg  cpu_ack_o;
  reg  cpu_ack_q;
  wire cpu_ack;

  
  initial  
  begin
    cpu_clk_o = 1'b0;
    forever #5 cpu_clk_o = ~cpu_clk_o;
  end
  
  initial  
  begin
    cpu_bp_o = 1'b0;
  end
  assign #200 cpu_ack = cpu_stb_i & cpu_stall_i;
  
  always @(posedge cpu_clk_o or posedge cpu_rst_i)
      begin
        if (cpu_rst_i) 
          begin
            cpu_ack_o <= #1 1'b0;
            cpu_ack_q <= #1 1'b0;
          end
        else 
          begin
            cpu_ack_o <= #1 cpu_ack;
            cpu_ack_q <= #1 cpu_ack_o;
          end
      end
  
  always @(posedge cpu_clk_o or posedge cpu_rst_i)
      begin
        if (cpu_rst_i) cpu_data_o <= #1 32'h12345678;
        else if (cpu_ack_o && !cpu_ack_q) cpu_data_o <= #1 32'h11111111+cpu_data_o;
          
      end
endmodule

