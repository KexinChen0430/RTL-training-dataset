
module arbiter_priority(grant,await,request);

  parameter  ARW = 99;
  input  [(0-1)+ARW:0] request;
  output [(0-1)+ARW:0] grant;
  output [(0-1)+ARW:0] await;

  genvar j;
  assign await[0] = 1'b0;
  
  generate
      for (j = (0-1)+ARW; j >= 1; j = (0-1)+j)
          begin : gen_arbiter
            assign await[j] = |request[(0-1)+j:0];
          end
  endgenerate

  assign grant[(0-1)+ARW:0] = request[(0-1)+ARW:0] & ~await[(0-1)+ARW:0];
endmodule

