
module IMG_TRI_BUFFER(data,rdaddress_a,rdaddress_b,rdclock,wraddress,wrclock,wren,
                      qa,qb);

  input  [7:0] data;
  input  [10:0] rdaddress_a;
  input  [10:0] rdaddress_b;
  input  rdclock;
  input  [10:0] wraddress;
  input  wrclock;
  input  wren;
  output [7:0] qa;
  output [7:0] qb;
  tri1 wren;


endmodule

