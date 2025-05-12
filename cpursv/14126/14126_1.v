
module processor_tb;

  reg  clk;
  reg  res;
  reg  [15:0] instruction_in;
  reg  [7:0] mdr_in;
  reg  [7:0] memory[255:0];
  wire [7:0] pc_out;
  wire [7:0] mdr_out;
  wire [7:0] mar_out;
  wire write_mem;

  processor uut(.clk(clk),.res(res),.instruction_in(instruction_in),
                .mdr_in(mdr_in),.pc_out(pc_out),.mdr_out(mdr_out),.mar_out(mar_out),
                .write_mem(write_mem));
  
  initial  
  begin
    clk = 0;
    res = 1;
    #100 res = 0;
  end
  
  always   #10 clk = ~clk;
  
  always @(posedge clk)
      begin
        if (write_mem) memory[mar_out] <= mdr_out;
          
        mdr_in <= memory[mar_out];
      end
  
  always @(pc_out)
      begin
        case (pc_out)

          8'h00: instruction_in = 16'h7f00;

          8'h01: instruction_in = 16'h0100;

          8'h02: instruction_in = 16'h0101;

          8'h03: instruction_in = 16'h7200;

          8'h04: instruction_in = 16'h730a;

          8'h05: instruction_in = 16'h0aff;

          8'h06: instruction_in = 16'h0101;

          8'h07: instruction_in = 16'h0000;

          8'h08: instruction_in = 16'h0100;

          8'h09: instruction_in = 16'h0201;

          8'h0a: instruction_in = 16'h0303;

          default: begin
                instruction_in = 16'hffff;
                $finish;
              end

        endcase

      end
endmodule

