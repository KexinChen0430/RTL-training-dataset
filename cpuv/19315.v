module stimulus #(parameter HW = 4, T = 10, M = 200) ( 
 output reg [2*HW-1:0] a 
 );
int i; 
int MAX; 
initial begin 
  MAX = 1 << 2*HW; 
  for (i = 0; i < M; i=i+1) begin 
    a = $random % MAX ; 
    #T; 
  end
end
endmodule 