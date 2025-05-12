
module regfile(data_out,data_in,wraddr,rdaddr,wren,clk);

  parameter  DEPTH = 8;
  parameter  WIDTH = 8;
  output [(-1)+WIDTH:0] data_out;
  input  [(-1)+WIDTH:0] data_in;
  input  clk;
  input  wren;
  input  [(-1)+DEPTH:0] wraddr,rdaddr;
  reg  [(-1)+WIDTH:0] data_out;
  reg  [(-1)+DEPTH:0] reg_file[(-1)+WIDTH:0];

  
  always @(posedge clk)
      begin
        if (wren) 
          begin
            reg_file[wraddr] <= data_in;
          end
        else 
          begin
            data_out <= reg_file[rdaddr];
          end
      end
endmodule

