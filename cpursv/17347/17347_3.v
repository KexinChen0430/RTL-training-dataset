
module linearmap(u,v,start,addr,texelselect,factor,enable,clk);

  input  [6:0] u;
  input  [6:0] v;
  input  [17:0] start;
  output [17:0] addr;
  reg  [17:0] addr;
  output [1:0] texelselect;
  wire [1:0] texelselect;
  input  [2:0] factor;
  input  enable;
  input  clk;
  reg  [6:0] ul;
  reg  [6:0] vl;

  assign texelselect = ul[1:0];
  
  always @(posedge clk)
      begin
        if (enable == 1'b1) 
          begin
            ul <= u;
            vl <= v;
          end
        else 
          begin
            ul <= ul;
            vl <= vl;
          end
        case (factor)

          3'b000: begin
                addr <= ({11'b00000000000,vl}+start)+{13'b0000000000000,ul[6:2]};
              end

          3'b001: begin
                addr <= ({13'b0000000000000,ul[6:2]}+start)+{10'b0000000000,vl,1'b0};
              end

          3'b010: begin
                addr <= ({13'b0000000000000,ul[6:2]}+start)+{9'b000000000,vl,2'b00};
              end

          3'b011: begin
                addr <= ({13'b0000000000000,ul[6:2]}+start)+{8'b00000000,vl,3'b000};
              end

          3'b100: begin
                addr <= {7'b0000000,vl,4'b0000}+({13'b0000000000000,ul[6:2]}+start);
              end

          3'b101: begin
                addr <= {13'b0000000000000,ul[6:2]}+({6'b000000,vl,5'b00000}+start);
              end

          3'b110: begin
                addr <= ({13'b0000000000000,ul[6:2]}+start)+{5'b00000,vl,6'b000000};
              end

          3'b111: begin
                addr <= start+({4'b0000,vl,7'b0000000}+{13'b0000000000000,ul[6:2]});
              end

        endcase

      end
endmodule

