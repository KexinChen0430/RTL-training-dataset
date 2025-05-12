module blk_mem #(
  parameter DATA_WIDTH      = 8,
  parameter ADDRESS_WIDTH   = 4,
  parameter INC_NUM_PATTERN = 0
)(
  input                             clka,
  input                             wea,
  input   [ADDRESS_WIDTH - 1  :0]   addra,
  input   [DATA_WIDTH - 1:0]        dina,
  input                             clkb,
  input   [ADDRESS_WIDTH - 1:0]     addrb,
  output  [DATA_WIDTH - 1:0]        doutb
);
reg [DATA_WIDTH - 1:0] mem [0:2 ** ADDRESS_WIDTH];
reg [DATA_WIDTH - 1:0] dout;
assign doutb = dout;
`ifdef SIMULATION
integer i;
initial begin
  i = 0;
  for (i = 0; i < (2 ** ADDRESS_WIDTH); i = i + 1) begin
    if (INC_NUM_PATTERN) begin
        mem[i]  <=  i;
    end
    else begin
        mem[i]  <=  0;
    end
  end
end
`endif
always @ (posedge clka)
begin
  if ( wea ) begin
     mem[addra] <= dina;
  end
end
always @ (posedge clkb)
begin
     dout <= mem[addrb];
end
endmodule