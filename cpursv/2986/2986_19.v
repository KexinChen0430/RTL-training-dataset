
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
  output [10:0] tag_out;
  reg  [76:0] mem[0:7];
  reg  [3:0] x;
  reg  [76:0] line;
  reg  we_del;
  wire we_filt;

  
  always @(we)  we_del <= we;
  assign we_filt = we & we_del;
  
  always @(clk or we_filt or negedge rst_n)
      if (!rst_n) 
        for (x = 0; x < 8; x = 1+x)
            mem[x] = {2'b00,{75{1'bx}}};
      else if (~clk && we_filt) mem[addr[2:0]] = {1'b1,wdirty,addr[13:3],wr_data};
        
  
  always @(clk or re or addr)
      if (clk && re) line = mem[addr[2:0]];
        
  assign hit = ((we | re) && (line[74:64] == addr[13:3])) ? line[76] : 1'b0;
  assign dirty = line[76] & line[75];
  assign rd_data = line[63:0];
  assign tag_out = line[74:64];
endmodule

