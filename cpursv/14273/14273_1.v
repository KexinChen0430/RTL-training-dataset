
module FIFO(data_out,empty,full,data_in,push,pop,reset,clk);

  parameter  DEPTH = 8;
  parameter  WIDTH = 8;
  output [WIDTH-1:0] data_out;
  output empty;
  output full;
  input  [WIDTH-1:0] data_in;
  input  push;
  input  pop;
  input  reset;
  input  clk;
  reg  [WIDTH-1:0] data_out;
  reg  empty,full;
  reg  [(-1)+DEPTH:0] wraddr,rdaddr;
  reg  [(-1)+DEPTH:0] reg_file[WIDTH-1:0];
  reg  [(-1)+DEPTH:0] num_elems;

  
  always @(reset)
      begin
        data_out = 8'd0;
        empty = 1'd0;
        full = 1'd0;
        wraddr = 8'd0;
        rdaddr = 8'd0;
        num_elems = 8'd0;
      end
  
  always @(posedge clk)
      begin
        if (push && (~pop && ~full)) 
          begin
            reg_file[wraddr] = data_in;
            wraddr = (1+wraddr)%DEPTH;
            num_elems = 1+num_elems;
            if (empty) empty = 1'd0;
              
            if ((num_elems == DEPTH) && (~empty && (wraddr == rdaddr))) full = 1'd1;
            else full = 1'd0;
          end
        else if (~push && ~empty && pop) 
          begin
            data_out = reg_file[rdaddr];
            rdaddr = (rdaddr+1)%DEPTH;
            num_elems = num_elems-1;
            if (full) full = 1'd0;
              
            if (wraddr == rdaddr) empty = 1'd1;
            else empty = 1'd0;
          end
          
      end
endmodule

