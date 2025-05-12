module fifo_same_clock_fill
#(
  parameter integer DATA_WIDTH=16, 
  parameter integer DATA_DEPTH=4   
)
(
  input                   rst,      
  input                   clk,      
  input                   sync_rst, 
  input                   we,       
  input                   re,       
  input  [DATA_WIDTH-1:0] data_in,  
  output [DATA_WIDTH-1:0] data_out, 
  output                  nempty,   
  output reg              half_full, 
  output reg              under,    
  output reg              over,     
  output reg [DATA_DEPTH-1:0] wcount, 
  output reg [DATA_DEPTH-1:0] rcount, 
  output     [DATA_DEPTH:0] wnum_in_fifo, 
  output     [DATA_DEPTH:0] rnum_in_fifo  
);
localparam integer DATA_2DEPTH=(1<<DATA_DEPTH)-1;
reg  [DATA_DEPTH:0] fill=0; 
reg  [DATA_DEPTH:0] wfifo_fill=0; 
reg  [DATA_DEPTH:0] rfifo_fill=0; 
reg  [DATA_WIDTH-1:0] inreg; 
reg  [DATA_WIDTH-1:0] outreg; 
reg  [DATA_DEPTH-1:0] ra; 
reg  [DATA_DEPTH-1:0] wa; 
wire [DATA_DEPTH:0] next_fill; 
reg  [1:0] wem; 
wire rem; 
reg  out_full=0; 
reg  [DATA_WIDTH-1:0] ram [0:DATA_2DEPTH]; 
reg  ram_nempty; 
assign next_fill = fill[DATA_DEPTH:0]+((wem[0] && ~rem)?1:((~wem[0] && rem && ram_nempty)?-1:0));
assign rem = ram_nempty && (re || !out_full);
assign data_out = outreg;
assign nempty = out_full;
assign wnum_in_fifo = wfifo_fill[DATA_DEPTH:0];
assign rnum_in_fifo = rfifo_fill[DATA_DEPTH:0];
always @ (posedge clk or posedge rst) begin
  if (rst || sync_rst) begin
    fill <= 0;
    wfifo_fill <= 0;
    rfifo_fill <= 0;
    wem <= 0;
    ram_nempty <= 0;
    wa <= 0;
    ra <= 0;
    out_full <= 0;
    wcount <= 0;
    rcount <= 0;
  end else begin
    fill <= next_fill;
    if (we && !re) wfifo_fill <= wfifo_fill+1;
    else if (!we && re) wfifo_fill <= wfifo_fill-1;
    if (wem[1] && !re) rfifo_fill <= rfifo_fill+1;
    else if (!wem[1] && re) rfifo_fill <= rfifo_fill-1;
    wem <= {wem[0], we};
    ram_nempty <= (next_fill != 0);
    if (wem[0]) wa <= wa+1;
    if (rem) ra <= ra+1;
    else if (!ram_nempty) ra <= wa; 
    if (rem && ~re) out_full <= 1;
    else if (re && ~rem) out_full <= 0;
    if (we) wcount <= wcount + 1;
    if (re) rcount <= rcount + 1;
  end
end
always @ (posedge clk) begin
  half_full <= (fill & (1<<(DATA_DEPTH-1))) != 0;
  if (wem[0]) ram[wa] <= inreg;
  if (we) inreg <= data_in;
  if (rem) outreg <= ram[ra];
  under <= re & ~nempty;
  over <= wem[0] & ~rem & fill[DATA_DEPTH] & ~fill[DATA_DEPTH-1];
end
endmodule