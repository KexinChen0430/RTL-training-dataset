module Register (
    clock, reset,
    enable,
    in_data, out_data
  );
  parameter
    WIDTH =         32,            
    INITIAL_VALUE = {WIDTH{1'b0}}, 
    RESET_VALUE =   {WIDTH{1'b0}}; 
  input               clock;       
  input               reset;       
  input               enable;      
  input   [WIDTH-1:0] in_data;     
  output  [WIDTH-1:0] out_data;    
  (* EXTRACT_ENABLE = "yes", EXTRACT_RESET = "yes" *)
  reg     [WIDTH-1:0] register_value; 
  assign out_data = register_value; 
  initial begin
    register_value = INITIAL_VALUE; 
  end
  always @ (posedge clock) begin 
    if (reset)        register_value <= RESET_VALUE; 
    else if (enable)  register_value <= in_data;     
  end
endmodule