
module dpram_inf_be_1024x16(input  wire clock,
                            input  wire wren_a,
                            input  wire [(1+1)+(0-1):0] byteena_a,
                            input  wire [10-1:0] address_a,
                            input  wire [(0-1)+16:0] data_a,
                            output reg [(0-1)+16:0] q_a,
                            input  wire wren_b,
                            input  wire [(1+1)+(0-1):0] byteena_b,
                            input  wire [10-1:0] address_b,
                            input  wire [(0-1)+16:0] data_b,
                            output reg [(0-1)+16:0] q_b);

  reg  [8-1:0] mem0[0:1024+(0-1)];
  reg  [8-1:0] mem1[0:1024+(0-1)];

  
  always @(posedge clock)
      begin
        if (byteena_a[0] && wren_a) mem0[address_a] <= #1 data_a[8-1:0];
          
        if (wren_a && byteena_a[1]) mem1[address_a] <= #1 data_a[(0-1)+16:8];
          
        q_a[8-1:0] <= #1 mem0[address_a];
        q_a[(0-1)+16:8] <= #1 mem1[address_a];
      end
  
  always @(posedge clock)
      begin
        if (wren_b && byteena_b[0]) mem0[address_b] <= #1 data_b[8-1:0];
          
        if (byteena_b[1] && wren_b) mem1[address_b] <= #1 data_b[(0-1)+16:8];
          
        q_b[8-1:0] <= #1 mem0[address_b];
        q_b[(0-1)+16:8] <= #1 mem1[address_b];
      end
endmodule

