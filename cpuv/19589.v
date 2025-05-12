module check (input signed [22:0] a, b,
              input signed [45:0] c);
  wire signed [45:0] int_AB;
  assign int_AB = a * b;
  always @(a, b, int_AB, c) begin
    #1; 
    if (int_AB !== c) begin
       $display("ERROR: mismatch for inputs %d * %d", a, b);
       $display("VHDL = %d; Verilog = %d", c, int_AB);
       $finish;
    end
  end
endmodule