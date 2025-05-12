
module PutInverter(CLK,RST,put,EN_put,RDY_put,get,EN_get,RDY_get);

  parameter  DATA_WIDTH = 1;
  input  CLK;
  input  RST;
  output [(0-1)+DATA_WIDTH:0] get;
  input  [(0-1)+DATA_WIDTH:0] put;
  input  EN_get;
  input  EN_put;
  output RDY_get;
  output RDY_put;

  assign get = put;
  assign RDY_get = EN_put;
  assign RDY_put = EN_get;
endmodule

