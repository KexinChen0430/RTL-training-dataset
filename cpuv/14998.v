module axi_clock_converter_v2_1_13_axic_sample_cycle_ratio # (
  parameter C_RATIO = 2 
  )
 (
  input  wire                    SLOW_ACLK,          
  input  wire                    FAST_ACLK,          
  output wire                    SAMPLE_CYCLE_EARLY, 
  output wire                    SAMPLE_CYCLE        
);
localparam P_DELAY = C_RATIO > 2 ? C_RATIO-1 : C_RATIO-1; 
reg                slow_aclk_div2 = 1'b0;            
reg                posedge_finder_first = 1'b0;      
reg                posedge_finder_second = 1'b0;     
wire               first_edge;                       
wire               second_edge;                      
wire               any_edge;                         
reg  [P_DELAY-1:0] sample_cycle_d = {P_DELAY{1'b0}}; 
(* shreg_extract = "no" *) reg                sample_cycle_r = 1'b0; 
generate
  if (C_RATIO == 1) begin : gen_always_sample
    assign SAMPLE_CYCLE_EARLY = 1'b1; 
    assign SAMPLE_CYCLE = 1'b1;       
  end
  else begin : gen_sample_cycle
    genvar i;
    always @(posedge SLOW_ACLK) begin
      slow_aclk_div2 <= ~slow_aclk_div2; 
    end
    always @(posedge FAST_ACLK) begin
      posedge_finder_first <= slow_aclk_div2; 
    end
    always @(posedge FAST_ACLK) begin
      posedge_finder_second <= ~slow_aclk_div2; 
    end
    assign first_edge = slow_aclk_div2 & ~posedge_finder_first; 
    assign second_edge = ~slow_aclk_div2 & ~posedge_finder_second; 
    assign any_edge = first_edge | second_edge; 
    for (i = P_DELAY-1; i > 0; i = i - 1) begin : gen_delay
      always @(posedge FAST_ACLK) begin
        if (i == P_DELAY-1) begin
          sample_cycle_d[i-1] <= any_edge; 
        end else begin
          sample_cycle_d[i-1] <= sample_cycle_d[i]; 
        end
      end
    end
    always @(posedge FAST_ACLK) begin
      sample_cycle_r <= (P_DELAY>1) ? sample_cycle_d[0] : any_edge; 
    end
    assign SAMPLE_CYCLE_EARLY = (P_DELAY>1) ? sample_cycle_d[0] : any_edge; 
    assign SAMPLE_CYCLE = sample_cycle_r; 
  end
endgenerate
endmodule