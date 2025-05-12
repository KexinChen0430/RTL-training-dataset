
module FSM_Ctrol(input  RST,
                 input  CLK,
                 input  STM,
                 output reg [7:0] ENa,
                 output reg [7:0] ENb,
                 output reg [7:0] ENc,
                 output reg [7:0] SEL,
                 output reg EOM);

  reg  [2:0] Qp,Qn;

  
  always @* 
      begin : Combinacional
        case (Qp)

          3'b000: begin
                if (STM) Qn = 3'b001;
                else Qn = Qp;
                ENa = 8'b00001111;
                ENb = 8'b00001111;
                ENc = 8'b00000000;
                SEL = 8'b00000000;
                EOM = 1'b1;
              end

        endcase

      end
  
  always @(posedge RST or posedge CLK)
      begin : Secuencial
        if (RST) Qp <= 0;
        else Qp <= Qn;
      end
endmodule

