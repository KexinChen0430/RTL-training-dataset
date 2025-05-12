module main();
  reg [31:0] x, y, newx;
  reg real alpha [0:15];
  reg real powers [0:16];
  reg real currangle, x_out, y_out;
  integer i;
  reg real AG_CONST, AG;
  initial begin
    AG_CONST = 1.20;
    AG = 2458;
    x = AG;
    y = 0;
    alpha[0] = 0;
    alpha[1] = 31.47292;
    alpha[15] = 0.00174;
    powers[0] = 0.00048828125; 
    powers[16] = 32.0;
    currangle = 90.0;
    for (i = 1; i < 15; i = i + 1) begin
      if (currangle > 0) begin
        while(currangle >= alpha[i]) begin
          newx = x + (y>>i);
          y = y+ (x >> i);
          x = newx;
          currangle = currangle - alpha[i];
        end
      end else begin
        while(currangle <= alpha[i]) begin
          newx = x - (y>>i);
          y = y- (x >> i);
          x = newx;
          currangle = currangle + alpha[i];
        end
      end
    end
    $display("x %f\n", x/2048.0);
    $display("y %f\n", y/2048.0);
    x_out = 0;
    y_out = 0;
    for (i = 0; i < 17; i = i + 1) begin
      x_out = (x[i]) ? x_out + powers[i] : x_out;
      y_out = (y[i]) ? y_out + powers[i] : y_out;
    end
    $display("x %f\n", x_out);
    $display("y %f\n", y_out);
  end
endmodule