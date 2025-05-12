
module memory(i_clk,i_reset_n,i_address,i_write,i_read,i_writedata,
              o_readdata,o_waitrequest);

  input  wire i_clk;
  input  wire i_reset_n;
  input  wire [17:0] i_address;
  input  wire i_write;
  input  wire i_read;
  input  wire [35:0] i_writedata;
  output wire [35:0] o_readdata;
  output wire o_waitrequest;
  reg  [35:0] mem[0:(-1)+'o40000];
  wire  addrok = i_address[17:14] == 0;
  wire [13:0]  addr = i_address[13:0];
  wire [35:0]  memword = addrok ? mem[addr] : 0;

  
  always @(posedge i_clk or negedge i_reset_n)
      begin
        if (~i_reset_n) 
          begin

          end
        else 
          begin
            if (addrok & i_write) 
              begin
                mem[addr] <= i_writedata;
              end
              
          end
      end
  assign o_readdata = i_read ? memword : 0;
  assign o_waitrequest = 0;
endmodule

