module or_a_submodule(
  output reg o_wbs_int,       
  input [31:0] gpio_in        
);
localparam GPIO                  = 32'h00000000; 
localparam GPIO_OUTPUT_ENABLE    = 32'h00000001; 
localparam INTERRUPTS            = 32'h00000002; 
localparam INTERRUPT_ENABLE      = 32'h00000003; 
localparam INTERRUPT_EDGE        = 32'h00000004; 
reg [31:0] gpio_direction;       
wire [31:0] gpio;                
reg [31:0] interrupts;           
reg [31:0] interrupt_mask;       
reg [31:0] interrupt_edge;       
reg clear_interrupts;            
endmodule