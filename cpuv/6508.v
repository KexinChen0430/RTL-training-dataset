module fifo_same_clock
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
  output reg              half_full 
`ifdef DEBUG_FIFO
  ,output reg                 under,    
  output reg                  over,     
  output reg [DATA_DEPTH-1:0] wcount,   
  output reg [DATA_DEPTH-1:0] rcount,   
  output     [DATA_DEPTH-1:0] num_in_fifo 
`endif
);
  localparam integer DATA_2DEPTH=(1<<DATA_DEPTH)-1;
  reg  [DATA_DEPTH-1:0] fill=0; 
  reg  [DATA_WIDTH-1:0] inreg;  
  reg  [DATA_WIDTH-1:0] outreg; 
  reg  [DATA_DEPTH-1:0] ra;     
  reg  [DATA_DEPTH-1:0] wa;     
  reg  wem;                     
  wire rem;                     
  reg  out_full=0;              
  reg  [DATA_WIDTH-1:0]   ram [0:DATA_2DEPTH]; 
  reg  ram_nempty;              
  assign rem= ram_nempty && (re || !out_full);
  assign data_out=outreg;
  assign nempty=out_full;
`ifdef DEBUG_FIFO
  assign num_in_fifo=fill[DATA_DEPTH-1:0];
`endif
  always @ (posedge clk or posedge rst) begin
    if      (rst)          fill <= 0; 
    else if (sync_rst)     fill <= 0; 
    else if ( wem && ~rem) fill <= fill + 1; 
    else if (~wem &&  rem) fill <= fill - 1; 
    if (rst)           wem <= 0;
    else if (sync_rst) wem <= 0;
    else               wem <= we;
    if   (rst)         ram_nempty <= 0;
    else if (sync_rst) ram_nempty <= 0;
    else               ram_nempty <= (|fill[DATA_DEPTH-1:1]) || (fill[0] && wem) || ((fill[0] || wem) && !rem);
    if (rst)           wa <= 0;
    else if (sync_rst) wa <= 0;
    else if (wem)      wa <= wa+1;
    if (rst)              ra <=  0;
    else if (sync_rst)    ra <= 0;
    else if (rem)         ra <= ra+1;
    else if (!ram_nempty) ra <= wa; 
    if (rst)             out_full <= 0;
    else if (sync_rst)   out_full <= 0;
    else if (rem && ~re) out_full <= 1; 
    else if (re && ~rem) out_full <= 0; 
`ifdef DEBUG_FIFO
    if (rst)            wcount <= 0;
    else if (sync_rst)  wcount <= 0;
    else if (we)        wcount <= wcount + 1;
    if (rst)           rcount <= 0;
    else if (sync_rst) rcount <= 0;
    else if (re)       rcount <= rcount + 1;
`endif
  }
  always @ (posedge clk) begin
    half_full <=(fill & (1<<(DATA_DEPTH-1)))!=0;
    if (wem) ram[wa] <= inreg;
    if (we)  inreg  <= data_in;
    if (rem) outreg <= ram[ra];
`ifdef DEBUG_FIFO
    under <= ~we & re & ~nempty; 
    over <=  we & ~re & (fill == (1<< (DATA_DEPTH-1))); 
`endif
  }
endmodule