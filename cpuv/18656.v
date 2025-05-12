module axi_register_slice_v2_1_14_tdm_sample (
  input  wire                    slow_clk, 
  input  wire                    fast_clk, 
  output wire                    sample_cycle 
);
reg                slow_clk_div2 = 1'b0; 
reg                posedge_finder_first; 
reg                posedge_finder_second; 
wire               first_edge; 
wire               second_edge; 
reg                sample_cycle_d; 
(* shreg_extract = "no" *) reg                sample_cycle_r; 
    always @(posedge slow_clk) begin
      slow_clk_div2 <= ~slow_clk_div2;
    end
    always @(posedge fast_clk) begin
      posedge_finder_first <= slow_clk_div2;
    end
    always @(posedge fast_clk) begin
      posedge_finder_second <= ~slow_clk_div2;
    end
    assign first_edge = slow_clk_div2 & ~posedge_finder_first;
    assign second_edge = ~slow_clk_div2 & ~posedge_finder_second;
    always @(*) begin
      sample_cycle_d = first_edge | second_edge;
    end
    always @(posedge fast_clk) begin
      sample_cycle_r <= sample_cycle_d;
    end
    assign sample_cycle = sample_cycle_r;
endmodule