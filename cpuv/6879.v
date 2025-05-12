module router_ctrl
  #( parameter CLIENTS=2,
     parameter WIDTH=32,
     parameter DELAY=1 )
(
  input  wire                     clk,
  input  wire                     reset,
  input  wire [CLIENTS-1:0]       empty,
  output wire [CLIENTS-1:0]       pop,
  input  wire [CLIENTS*WIDTH-1:0] data_in,
  input  wire                     full,
  output reg                      push,
  output wire [WIDTH-1:0]         data_out,
  output wire                     cycle,
  output wire [CLIENTS-1:0]       req,
  input  wire [CLIENTS-1:0]       gnt
);
reg [CLIENTS-1:0] pop_delay_chain [DELAY:0];
assign cycle = !full;
assign req   = ~empty;
assign pop   = gnt;
assign push  = |pop_delay_chain[DELAY];
always @ (*) begin
  pop_delay_chain[0] = pop;
end
integer pdc_index;
always @ (posedge clk) begin
  for( pdc_index=1; pdc_index<=DELAY; pdc_index=pdc_index+1 ) begin
    if( reset ) begin
      pop_delay_chain[pdc_index] <= #0 0;
    end
    else begin
      pop_delay_chain[pdc_index] <= #0 pop_delay_chain[pdc_index-1];
    end
  end
end
integer mux_index;
always @ (*) begin
  data_out = {WIDTH{1'b0}};
  for( mux_index=0; mux_index<CLIENTS; mux_index=mux_index+1 ) begin
    if( pop_delay_chain[mux_index] ) begin
      data_out = data_in[(mux_index+1)*WIDTH-1:mux_index*WIDTH];
    end
  end
end
endmodule