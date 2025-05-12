module rc4_old(ready, k, clk, rst, keyinput, need);
parameter keylength = 8; 
output reg ready; 
output reg [7:0] k; 
input clk; 
input rst; 
input [7:0] keyinput; 
input need; 
reg [7:0] key[0:keylength-1]; 
reg [3:0] state; 
reg [7:0] stream[0:255]; 
reg [7:0] stream_temp; 
reg [7:0] i; 
reg [7:0] j; 
reg [7:0] tmp; 
initial begin
  ready = 1; 
  state = `RC4_KEYREAD; 
  i = 8'h00; 
  j = 8'h00; 
end
always @ (posedge clk) begin
  if (rst) begin
    ready = 0; 
    state = `RC4_KEYREAD; 
    i = 8'h00; 
    j = 8'h00; 
  end
  case (state)
    `RC4_KEYREAD: begin
      if (i == keylength) begin
        state = `RC4_KSA1; 
        i = 8'h00; 
      end else begin
        $display("key[%d] = %02X", i, keyinput); 
        key[i] = keyinput; 
        i = i + 8'h01; 
      end
    end
    `RC4_KSA1: begin
      stream[i] = i; 
      if (i == 8'hff) begin
        state = `RC4_KSA2; 
        i = 8'h00; 
      end else begin
        i = i + 8'h01; 
      end
    end
    `RC4_KSA2: begin
      state = `RC4_KSA3; 
      stream_temp = stream[i]; 
      j = j + stream[i] + key[i % keylength]; 
    end
    `RC4_KSA3: begin
      stream[i] = stream[j]; 
      stream[j] = stream_temp; 
      if (i == 8'hff) begin
        state = `RC4_NEED; 
        i = 8'h01; 
        j = stream[1]; 
      end else begin
        state = `RC4_KSA2; 
        i = i + 8'h01; 
      end
    end
    `RC4_NEED: begin
      if (need) state = `RC4_PRGA1; 
    end
    `RC4_PRGA1: begin
      ready = 0; 
      state = `RC4_PRGA2; 
      stream_temp = stream[i]; 
    end
    `RC4_PRGA2: begin
      state = `RC4_PRGA3; 
      stream[i] = stream[j]; 
      stream[j] = stream_temp; 
      tmp = stream[i] + stream[j]; 
    end
    `RC4_PRGA3: begin
      ready = 1; 
      k = stream[tmp]; 
      state = `RC4_NEED; 
      if (i == 8'hff) j = j + stream[0]; 
      else j = j + stream[i + 1]; 
      i = i + 1; 
    end
    default: begin
    end
  endcase
end
endmodule