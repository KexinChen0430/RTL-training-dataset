
module register(ridx,widx,wdata,we,clk,reset,rdata);

  input  wire [4:0] ridx;
  input  wire [4:0] widx;
  input  wire [31:0] wdata;
  input  wire we;
  input  wire clk;
  input  wire reset;
  output wire [31:0] rdata;
  reg  [31:0] mem[31:0];
  reg  [31:0] i;

  
  task resetReg;

    begin
      for (i = 0; i < 32; i = 1+i)
          begin
            mem[i] = 32'b0;
          end
    end
  endtask
  
  initial  
  begin
    resetReg;
  end
  assign rdata = mem[ridx];
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            resetReg;
          end
        else 
          begin
            if (we & (widx != 32'b0)) 
              begin
                mem[widx] <= wdata;
              end
              
          end
      end
endmodule

