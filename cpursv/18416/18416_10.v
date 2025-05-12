
module cache(clk,rst_n,addr,wr_data,wdirty,we,re,rd_data,tag_out,hit,
             dirty);

  input  clk,rst_n;
  input  [13:0] addr;
  input  [63:0] wr_data;
  input  wdirty;
  input  we;
  input  re;
  output hit;
  output dirty;
  output [63:0] rd_data;
  output [7:0] tag_out;
  reg  [73:0] mem[0:63];
  reg  [6:0] x;
  reg  [73:0] line;
  reg  we_del;
  wire we_filt;

  
  always @(we)  we_del <= we;
  assign we_filt = we_del & we;
  
  always @(posedge clk or negedge rst_n)
      if (!rst_n) 
        for (x = 0; x < 64; x = 1+x)
            mem[x] = {2'b00,{72{1'bx}}};
      else if (we_filt) mem[addr[6:0]] = {1'b1,wdirty,addr[13:6],wr_data};
        
  
  always @(posedge clk)
      if (re) line = mem[addr[6:0]];
        
  assign hit = ((we | re) && (line[71:64] == addr[13:6])) ? line[73] : 1'b0;
  assign dirty = line[73] & line[72];
  assign rd_data = line[63:0];
  assign tag_out = line[71:64];
endmodule

