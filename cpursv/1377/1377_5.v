
module rcswitch_send(input  clk,
                     input  rst,
                     input  send,
                     input  [39:0] addr,
                     input  [39:0] chan,
                     input  [15:0] stat,
                     output ready,
                     output out);

  reg  r_out;
  reg  r_ready;
  reg  [7:0] pos;
  reg  [127:0] msg;

  
  initial  
  begin
    r_ready <= 1;
    r_out <= 0;
    pos <= 0;
    msg <= 0;
  end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            r_ready <= 1;
            r_out <= 0;
            pos <= 0;
          end
        else 
          begin
            if (send && (pos == 0)) 
              begin
                pos <= 128;
                r_ready <= 0;
                msg[127:0] <= {addr[39:0],chan[39:0],stat[15:0],32'b10000000_00000000_00000000_00000000};
              end
            else if (pos > 0) 
              begin
                pos <= (-1)+pos;
                r_out <= msg>>pos;
                if (pos == 0) 
                  begin
                    r_ready <= 1;
                    r_out <= 0;
                    pos <= 0;
                  end
                else 
                  begin
                    r_ready <= 0;
                  end
              end
            else 
              begin
                msg <= ~msg;
              end
          end
      end
  assign ready = r_ready;
  assign out = r_out;
endmodule

