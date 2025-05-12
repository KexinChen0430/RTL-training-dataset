module top; 
  reg [31:0] data; 
  reg [31:0] addr; 
  reg wr_en; 
  reg rd_en; 
  reg [31:0] rd_data; 
  initial begin 
    $readmemh("mem_init.txt", mem); 
    addr = 32'h0000_0000; 
    wr_en = 1'b1; 
    rd_en = 1'b0; 
    data = 32'h1234_5678; 
    #10; 
    wr_en = 1'b0; 
    rd_en = 1'b1; 
    #10; 
    if (rd_data !== 32'h1234_5678) begin 
      $display("Error: Memory read data is incorrect at time %0d:\n", $time); 
      $stop(1); 
    end
  end
  task mem_access; 
    input [31:0] addr; 
    input wr_en; 
    input rd_en; 
    input [31:0] wr_data; 
    output [31:0] rd_data; 
    begin
      if (wr_en) 
        mem[addr] = wr_data; 
      if (rd_en) 
        rd_data = mem[addr]; 
    end
  endtask 
endmodule 