module stack2pipe4(
  input wire clk, 
  output wire [`WIDTH-1:0] rd, 
  input wire we, 
  input wire [1:0] delta, 
  input wire [`WIDTH-1:0] wd); 
  parameter DEPTH = 18;
  localparam BITS = (`WIDTH * DEPTH) - 1;
  localparam STATESIZE = `WIDTH * (DEPTH + 1);
  localparam STATEBITS = STATESIZE - 1;
  localparam DELAYBITS = (STATESIZE * 3) - 1;
  wire move = delta[0]; 
  wire pop = delta[1]; 
  reg [15:0] head; 
  reg [BITS:0] tail; 
  reg [DELAYBITS:0] delay; 
  wire [15:0] headN, oldhead; 
  wire [BITS:0] tailN, oldtail; 
  wire [DELAYBITS:0] delayN; 
  assign {oldtail, oldhead} = delay[STATEBITS:0];
  assign rd = oldhead;
  assign headN = we ? wd : (move ? oldtail[15:0] : oldhead);
  assign tailN = move ? (pop ? {16'h55aa, oldtail[BITS:16]} : {oldtail[BITS-16:0], oldhead}) : oldtail;
  assign delayN = {tail, head, delay[DELAYBITS:STATESIZE]};
  always @(posedge clk) begin
    delay <= delayN; 
    head <= headN; 
    tail <= tailN; 
  end
`ifdef VERILATOR
  int depth ; 
  always @(posedge clk) begin
    if (delta == 2'b11)
      depth <= depth - 1; 
    if (delta == 2'b01)
      depth <= depth + 1; 
  end
`endif
endmodule