
module crc_7(start,clk,rst,data_in,data_out,done);

  input  start;
  input  clk;
  input  rst;
  input  [datawidth+(0-1):0] data_in;
  output [crcorder:0] data_out;
  output done;
  localparam  datawidth = 32, crcorder = 7;
  localparam  polinomio = 8'b10001001;
  reg  rdone;
  reg  [datawidth+(0-1):0] r_data;
  reg  [crcorder:0] proceso;

  
  initial    rdone = 1'b0;
  localparam 
       INIT   = 3'd0,
       GET    = 3'd1,
       COMP   = 3'd2,
       XOR    = 3'd3,
       CORRER = 3'd4,
       SEND   = 3'd5;

  reg  [1<<1:0] state;

  
  initial    state = INIT;
  reg  [6:0] cont;

  assign data_out = proceso;
  assign done = rdone;
  
  always @(posedge clk or negedge clk)
      begin
        if (rst) 
          begin
            rdone <= 0;
            cont <= 0;
            proceso <= 0;
            state = INIT;
          end
        else 
          begin
            case (state)

              INIT: begin
                    cont <= 6'd0;
                    rdone <= 1'b0;
                    if (start) 
                      begin
                        r_data <= data_in;
                        state = GET;
                      end
                      
                  end

              GET: begin
                    proceso <= r_data[datawidth+(0-1):(0-1)+((0-crcorder)+datawidth)];
                    state = COMP;
                  end

              COMP: begin
                    cont <= 1'b1+cont;
                    if (proceso[crcorder]) state = XOR;
                    else state = CORRER;
                  end

              XOR: begin
                    proceso <= (proceso & (((~polinomio | (~proceso & polinomio)) | proceso) | ((~proceso & polinomio) | (~proceso & ((polinomio | ~polinomio) & proceso))))) ^ (polinomio & (((~polinomio | (~proceso & polinomio)) | proceso) | ((~proceso & polinomio) | (~proceso & ((polinomio | ~polinomio) & proceso)))));
                    state = CORRER;
                  end

              CORRER: begin
                    r_data <= {proceso[crcorder:0],r_data[((0-1)+((0-crcorder)+datawidth))-1:0],1'b0};
                    if (cont == datawidth) state = SEND;
                    else state = GET;
                  end

              SEND: begin
                    rdone <= 1'b1;
                    state = INIT;
                  end

            endcase

          end
      end
endmodule

