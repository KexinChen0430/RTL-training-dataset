
module arbiter_priority(grant,await,request);

  parameter  ARW = 99;
  input  [(-1)+ARW:0] request;
  output [(-1)+ARW:0] grant;
  output [(-1)+ARW:0] await;

  genvar j;
  assign await[0] = 1'b0;
  
  generate
      for (j = (-1)+ARW; j >= 1; j = (-1)+j)
          begin : gen_arbiter
            assign await[j] = |request[(-1)+j:0];
          end
  endgenerate

  assign grant[(-1)+ARW:0] = request[(-1)+ARW:0] & ~await[(-1)+ARW:0];
endmodule

