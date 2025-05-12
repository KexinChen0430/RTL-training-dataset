
module sfifo_nto8(clk,ce,nrst,reset,din,dout,rd,wr,full,empty,nsin,nsout);

  input  clk;
  input  ce;
  input  nrst;
  input  reset;
  input  [7:0] din;
  output [7:0] dout;
  input  rd;
  input  wr;
  output full;
  output empty;
  input  [3:0] nsin;
  input  [3:0] nsout;
  reg  [23:0] buffer;
  reg  [5:0] cnt;
  wire [31:0] shift_out;
  wire [31:0] shift_in;
  wire [5:0] space_left;

  assign dout = shift_out[31:24];
  assign full = (nsin+cnt) > 24;
  assign empty = cnt < nsout;
  
  always @(posedge clk or negedge nrst)
      if (~nrst) cnt <= 0;
      else if (ce) 
        begin
          if (reset) cnt <= 0;
          else 
            begin
              if (rd & wr) cnt <= (nsin+cnt)+(-nsout);
                
              if (~rd & wr) cnt <= nsin+cnt;
                
              if (~wr & rd) cnt <= cnt-nsout;
                
            end
        end
        
  assign shift_out = 1<<<nsout*{8'h0,buffer};
  assign space_left = rd ? ((0-cnt)+(24+nsout)) : (24+(0-cnt));
  assign shift_in = {24'h0,din}<<<space_left;
  
  always @(posedge clk or negedge nrst)
      if (~nrst) buffer <= 0;
      else if (ce) 
        begin
          if (reset) buffer <= 0;
          else 
            begin
              if (rd & wr) buffer <= shift_out[23:0] | shift_in[31:8];
                
              if (~rd & wr) buffer <= buffer | shift_in[31:8];
                
              if (~wr & rd) buffer <= shift_out[23:0];
                
            end
        end
        
endmodule

