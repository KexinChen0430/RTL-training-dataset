
module regfile(data_out,data_in,wraddr,rdaddr,wren,clk);

  parameter  DEPTH = 8;
  parameter  WIDTH = 8;
  output [(0-1)+WIDTH:0] data_out;
  input  [(0-1)+WIDTH:0] data_in;
  input  clk;
  input  wren;
  input  [DEPTH-1:0] wraddr,rdaddr;
  reg  [(0-1)+WIDTH:0] data_out;
  reg  [DEPTH-1:0] reg_file[(0-1)+WIDTH:0];

  
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

