module check (input unsigned [103:0] a, b, c);
  wire [103:0] int_AB;
  assign int_AB = ~(a & b);
  always @(a, b, int_AB, c) begin
    #1;
    if (int_AB !== c) begin
      $display("ERROR");
      $finish;
    end
  end
endmodule